// aggregator.js
import { randomUUID } from "crypto";
import { pool } from "./db.js";

function isoDateString(date) {
  return date.toISOString().split("T")[0];
}

export const handler = async (event) => {
  const client = await pool.connect();
  try {
    let targetDate;

    const now = new Date();
    now.setUTCDate(now.getUTCDate() - 3);
    targetDate = new Date(
      Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate())
    );

    const dayStart = new Date(
      Date.UTC(
        targetDate.getUTCFullYear(),
        targetDate.getUTCMonth(),
        targetDate.getUTCDate(),
        0,
        0,
        0
      )
    );
    const dayEnd = new Date(
      Date.UTC(
        targetDate.getUTCFullYear(),
        targetDate.getUTCMonth(),
        targetDate.getUTCDate() + 1,
        0,
        0,
        0
      )
    );

    const metricsDate = isoDateString(dayStart); // YYYY-MM-DD

    console.info(
      `Aggregating metrics for date=${metricsDate} (from ${dayStart.toISOString()} to ${dayEnd.toISOString()})`
    );

    // 2) Query agregada para PRODUCTS (conta views por source, chats, favorites)
    const productsQuery = `
      SELECT
        entity_id AS product_id,
        COUNT(*) FILTER (WHERE event_type IN ('view','visualized')) AS views_total,
        COUNT(*) FILTER (WHERE (event_type IN ('view','visualized')) AND source = 'link') AS views_from_link,
        COUNT(*) FILTER (WHERE (event_type IN ('view','visualized')) AND source = 'feed') AS views_from_feed,
        COUNT(*) FILTER (WHERE (event_type IN ('view','visualized')) AND source = 'search') AS views_from_search,
        COUNT(*) FILTER (WHERE (event_type IN ('view','visualized')) AND source = 'gallery') AS views_from_gallery,
        COUNT(*) FILTER (WHERE event_type = 'chat_opened') AS chat_opened,
        COUNT(*) FILTER (WHERE event_type = 'chat_message_sent') AS chat_messages,
        COUNT(*) FILTER (WHERE event_type IN ('favorite','favorite_added')) AS favorites_total
      FROM metrics_raw_events
      WHERE entity_type = 'product'
        AND created_at >= $1
        AND created_at < $2
      GROUP BY entity_id;
    `;

    const prodRes = await client.query(productsQuery, [
      dayStart.toISOString(),
      dayEnd.toISOString(),
    ]);

    // 3) Upsert dos produtos: idempotente (substitui os valores daquele dia)
    // Usamos ON CONFLICT (product_id, metrics_date) DO UPDATE SET ... para substituir
    for (const row of prodRes.rows) {
      const upsertProductQuery = `
        INSERT INTO products_metrics_daily (
          id, product_id,
          views_total, views_from_link, views_from_feed, views_from_search, views_from_gallery,
          chat_opened, chat_messages, favorites_total,
          metrics_date
        ) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)
        ON CONFLICT (product_id, metrics_date)
        DO UPDATE SET
          views_total = EXCLUDED.views_total,
          views_from_link = EXCLUDED.views_from_link,
          views_from_feed = EXCLUDED.views_from_feed,
          views_from_search = EXCLUDED.views_from_search,
          views_from_gallery = EXCLUDED.views_from_gallery,
          chat_opened = EXCLUDED.chat_opened,
          chat_messages = EXCLUDED.chat_messages,
          favorites_total = EXCLUDED.favorites_total
      `;

      const values = [
        randomUUID(), // id novo (se inserir)
        row.product_id,
        Number(row.views_total ?? 0),
        Number(row.views_from_link ?? 0),
        Number(row.views_from_feed ?? 0),
        Number(row.views_from_search ?? 0),
        Number(row.views_from_gallery ?? 0),
        Number(row.chat_opened ?? 0),
        Number(row.chat_messages ?? 0),
        Number(row.favorites_total ?? 0),
        metricsDate,
      ];

      await client.query(upsertProductQuery, values);
    }

    // 4) Query agregada para GALLERIES (views e shares)
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
      dayStart.toISOString(),
      dayEnd.toISOString(),
    ]);

    // 5) Upsert das galerias
    for (const row of galRes.rows) {
      const upsertGalQuery = `
        INSERT INTO gallery_metrics_daily (
          id, gallery_id, views_total, shared_total, metrics_date
        ) VALUES ($1,$2,$3,$4,$5)
        ON CONFLICT (gallery_id, metrics_date)
        DO UPDATE SET
          views_total = EXCLUDED.views_total,
          shared_total = EXCLUDED.shared_total
      `;

      const values = [
        randomUUID(),
        row.gallery_id,
        Number(row.views_total ?? 0),
        Number(row.shared_total ?? 0),
        metricsDate,
      ];

      await client.query(upsertGalQuery, values);
    }

    console.info(
      `Aggregated products: ${prodRes.rowCount}, galleries: ${galRes.rowCount} for date ${metricsDate}`
    );

    return {
      statusCode: 200,
      body: JSON.stringify({
        products: prodRes.rowCount,
        galleries: galRes.rowCount,
        date: metricsDate,
      }),
    };
  } catch (err) {
    console.error("Aggregator error:", err);
    throw err;
  } finally {
    client.release();
  }
};
handler();
