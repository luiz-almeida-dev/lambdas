import { pool } from "./db.js";
import { generateId } from "./generateId.js";

function isoDateString(date) {
  return date.toISOString().split("T")[0];
}

export const handler = async () => {
  const client = await pool.connect();

  try {
    const now = new Date();

    const endHour = new Date(
      Date.UTC(
        now.getUTCFullYear(),
        now.getUTCMonth(),
        now.getUTCDate(),
        now.getUTCHours(),
        0,
        0
      )
    );

    const startHour = new Date(endHour);
    startHour.setUTCHours(startHour.getUTCHours() - 1);

    const metricsDate = isoDateString(startHour);

    console.info(
      `Hourly aggregation from ${startHour.toISOString()} to ${endHour.toISOString()}`
    );

    const productsQuery = `
      SELECT
        entity_id AS product_id,
        COUNT(*) FILTER (WHERE event_type IN ('view','visualized')) AS views_total,
        COUNT(*) FILTER (WHERE event_type IN ('view','visualized') AND source = 'expo') AS views_from_expo,
        COUNT(*) FILTER (WHERE event_type IN ('view','visualized') AND source = 'feed') AS views_from_feed,
        COUNT(*) FILTER (WHERE event_type IN ('view','visualized') AND source = 'search') AS views_from_search,
        COUNT(*) FILTER (WHERE event_type IN ('view','visualized') AND source = 'gallery') AS views_from_gallery,
        COUNT(*) FILTER (WHERE event_type = 'chat_opened') AS chat_opened,
        COUNT(*) FILTER (WHERE event_type = 'chat_message_sent') AS chat_messages
      FROM metrics_raw_events
      WHERE entity_type = 'product'
        AND created_at >= $1
        AND created_at < $2
      GROUP BY entity_id;
    `;

    const prodRes = await client.query(productsQuery, [
      startHour.toISOString(),
      endHour.toISOString(),
    ]);

    for (const row of prodRes.rows) {
      const upsertProductQuery = `
        INSERT INTO products_metrics_daily (
          id,
          product_id,
          views_total,
          views_from_expo,
          views_from_feed,
          views_from_search,
          views_from_gallery,
          chat_opened,
          chat_messages,
          metrics_date,
          last_aggregated_at
        )
        VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)
        ON CONFLICT (product_id, metrics_date)
        DO UPDATE SET
          views_total = products_metrics_daily.views_total + EXCLUDED.views_total,
          views_from_expo = products_metrics_daily.views_from_expo + EXCLUDED.views_from_expo,
          views_from_feed = products_metrics_daily.views_from_feed + EXCLUDED.views_from_feed,
          views_from_search = products_metrics_daily.views_from_search + EXCLUDED.views_from_search,
          views_from_gallery = products_metrics_daily.views_from_gallery + EXCLUDED.views_from_gallery,
          chat_opened = products_metrics_daily.chat_opened + EXCLUDED.chat_opened,
          chat_messages = products_metrics_daily.chat_messages + EXCLUDED.chat_messages,
          last_aggregated_at = EXCLUDED.last_aggregated_at;
      `;

      await client.query(upsertProductQuery, [
        generateId(),
        row.product_id,
        Number(row.views_total ?? 0),
        Number(row.views_from_expo ?? 0),
        Number(row.views_from_feed ?? 0),
        Number(row.views_from_search ?? 0),
        Number(row.views_from_gallery ?? 0),
        Number(row.chat_opened ?? 0),
        Number(row.chat_messages ?? 0),
        metricsDate,
        endHour.toISOString(),
      ]);
    }

    const galleriesQuery = `
      SELECT
        entity_id AS gallery_id,
        COUNT(*) FILTER (WHERE event_type IN ('view','visualized','gallery_view')) AS views_total,
        COUNT(*) FILTER (WHERE event_type IN ('share','shared','gallery_shared')) AS shared_total
      FROM metrics_raw_events
      WHERE entity_type = 'gallery'
        AND created_at >= $1
        AND created_at < $2
      GROUP BY entity_id;
    `;

    const galRes = await client.query(galleriesQuery, [
      startHour.toISOString(),
      endHour.toISOString(),
    ]);

    for (const row of galRes.rows) {
      const upsertGalleryQuery = `
        INSERT INTO gallery_metrics_daily (
          id,
          gallery_id,
          views_total,
          shared_total,
          metrics_date,
          last_aggregated_at
        )
        VALUES ($1,$2,$3,$4,$5,$6)
        ON CONFLICT (gallery_id, metrics_date)
        DO UPDATE SET
          views_total = gallery_metrics_daily.views_total + EXCLUDED.views_total,
          shared_total = gallery_metrics_daily.shared_total + EXCLUDED.shared_total,
          last_aggregated_at = EXCLUDED.last_aggregated_at;
      `;

      await client.query(upsertGalleryQuery, [
        generateId(),
        row.gallery_id,
        Number(row.views_total ?? 0),
        Number(row.shared_total ?? 0),
        metricsDate,
        endHour.toISOString(),
      ]);
    }

    console.info(
      `Hourly aggregation completed. Products: ${prodRes.rowCount}, Galleries: ${galRes.rowCount}`
    );

    return {
      statusCode: 200,
      body: JSON.stringify({
        products: prodRes.rowCount,
        galleries: galRes.rowCount,
        from: startHour.toISOString(),
        to: endHour.toISOString(),
      }),
    };
  } catch (error) {
    console.error("Hourly aggregator error:", error);
    throw error;
  } finally {
    client.release();
  }
};
