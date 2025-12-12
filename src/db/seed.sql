-- Dia atual
INSERT INTO metrics_raw_events
(id, entity_id, entity_type, event_type, source, created_at)
VALUES
-- ===== PRODUTO 1: Views diferentes sources =====
('aK3fT9pQwLx7R2uSd8Y_', 'hTVIA8raTAHFJtnHI3M9lA7kRahb', 'product', 'view', 'feed', now() - interval '10 minutes'),
('Zp9mQv6rHbA2kUfT0xLw', 'hTVIA8raTAHFJtnHI3M9lA7kRahb', 'product', 'view', 'feed', now() - interval '9 minutes'),
('Jt4Vb2nQKf8yU0sEaP1h', 'hTVIA8raTAHFJtnHI3M9lA7kRahb', 'product', 'view', 'search', now() - interval '8 minutes'),
('qW7eL1rXyT9pF6sDbM3Z', 'hTVIA8raTAHFJtnHI3M9lA7kRahb', 'product', 'view', 'gallery', now() - interval '7 minutes'),
('Mu0SxP4eHb1Qk9tZyL6g', 'hTVIA8raTAHFJtnHI3M9lA7kRahb', 'product', 'view', 'link', now() - interval '6 minutes'),

-- Favorito e Chat PRODUTO 1
('Vr8dE2pNcK5wZq1BfT0u', 'hTVIA8raTAHFJtnHI3M9lA7kRahb', 'product', 'favorite', NULL, now() - interval '5 minutes'),
('sT2kQ9nDfW8pL3yHaR7v', 'hTVIA8raTAHFJtnHI3M9lA7kRahb', 'product', 'chat_opened', NULL, now() - interval '4 minutes'),
('Bx1fG7wLkC9tM0sYeP4r', 'hTVIA8raTAHFJtnHI3M9lA7kRahb', 'product', 'chat_message_sent', NULL, now() - interval '3 minutes'),

-- ===== PRODUTO 2: Mix de eventos =====
('Yt5bW3nQcH0eK8fSrP2x', '1upLzH6hTG6walDUtDkdOV8uFQ8i', 'product', 'view', 'feed', now() - interval '12 minutes'),
('pD0mR6qVxJ3uN9cTbF4a', '1upLzH6hTG6walDUtDkdOV8uFQ8i', 'product', 'view', 'feed', now() - interval '11 minutes'),
('wA9kS1hTfC7yQ4uMbP0n', '1upLzH6hTG6walDUtDkdOV8uFQ8i', 'product', 'view', 'gallery', now() - interval '10 minutes'),
('Nf3uX5cQpR7hJ2tWmK8z', '1upLzH6hTG6walDUtDkdOV8uFQ8i', 'product', 'favorite', NULL, now() - interval '9 minutes'),
('gH4kP2tSdA1nL8yMfR6b', '1upLzH6hTG6walDUtDkdOV8uFQ8i', 'product', 'favorite', NULL, now() - interval '8 minutes'),
('Ue7rK1pFxT8hC0mSaQ5y', '1upLzH6hTG6walDUtDkdOV8uFQ8i', 'product', 'chat_opened', NULL, now() - interval '7 minutes'),

-- ===== GALERIA 1: Views =====
('cL2tJ6xFbQ9nA3rHyP8k', 'mwAFdeOJQN97F7QLPU0DWnnHtgde', 'gallery', 'view', NULL, now() - interval '20 minutes'),
('Rj5hN0sQpK1uZ8tVbM3d', 'mwAFdeOJQN97F7QLPU0DWnnHtgde', 'gallery', 'view', NULL, now() - interval '19 minutes'),
('Lw9mC4fSaB7xD2tQpR1v', 'mwAFdeOJQN97F7QLPU0DWnnHtgde', 'gallery', 'share', NULL, now() - interval '18 minutes'),

-- ===== GALERIA 2: Views =====
('Zk8uE2mWpN1bV5rQsH0c', 'ZaKBpL4rG31YOjNIgYaS4vQhR1fx', 'gallery', 'view', NULL, now() - interval '25 minutes'),
('tH3cV9bLpA0xS6yDqP4e', 'ZaKBpL4rG31YOjNIgYaS4vQhR1fx', 'gallery', 'view', NULL, now() - interval '24 minutes'),
('oP7dG1wTfM2hR8nBxQ5z', 'ZaKBpL4rG31YOjNIgYaS4vQhR1fx', 'gallery', 'share', NULL, now() - interval '23 minutes');

-- 1 dia atrás
INSERT INTO metrics_raw_events
(id, entity_id, entity_type, event_type, source, created_at)
VALUES
-- ===== PRODUTO 1 =====
('P1d1_a1', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'feed', now() - interval '1 day' - interval '12 minutes'),
('P1d1_a2', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'gallery', now() - interval '1 day' - interval '11 minutes'),
('P1d1_a3', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'search', now() - interval '1 day' - interval '10 minutes'),
('P1d1_a4', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'feed', now() - interval '1 day' - interval '9 minutes'),
('P1d1_a5', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'link', now() - interval '1 day' - interval '8 minutes'),

-- Favorito + Chat PRODUTO 1
('P1d1_fav1', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'favorite', NULL, now() - interval '1 day' - interval '7 minutes'),
('P1d1_chat1', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'chat_opened', NULL, now() - interval '1 day' - interval '6 minutes'),
('P1d1_chat2', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'chat_message_sent', NULL, now() - interval '1 day' - interval '5 minutes'),

-- ===== PRODUTO 2 =====
('P2d1_v1', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'view', 'feed', now() - interval '1 day' - interval '20 minutes'),
('P2d1_v2', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'view', 'search', now() - interval '1 day' - interval '19 minutes'),
('P2d1_v3', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'view', 'gallery', now() - interval '1 day' - interval '18 minutes'),
('P2d1_fav1', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'favorite', NULL, now() - interval '1 day' - interval '17 minutes'),
('P2d1_fav2', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'favorite', NULL, now() - interval '1 day' - interval '16 minutes'),
('P2d1_chat1', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'chat_opened', NULL, now() - interval '1 day' - interval '15 minutes'),

-- ===== GALERIA 1 =====
('G1d1_v1', 'd6TGw8rvksb57BGhNYnet9ThqrRJ', 'gallery', 'view', NULL, now() - interval '1 day' - interval '30 minutes'),
('G1d1_v2', 'd6TGw8rvksb57BGhNYnet9ThqrRJ', 'gallery', 'view', NULL, now() - interval '1 day' - interval '29 minutes'),
('G1d1_share1', 'd6TGw8rvksb57BGhNYnet9ThqrRJ', 'gallery', 'share', NULL, now() - interval '1 day' - interval '28 minutes'),

-- ===== GALERIA 2 =====
('G2d1_v1', 'alZaQcmUUQAt3TIFxLxwTmkw9cAp', 'gallery', 'view', NULL, now() - interval '1 day' - interval '40 minutes'),
('G2d1_v2', 'alZaQcmUUQAt3TIFxLxwTmkw9cAp', 'gallery', 'view', NULL, now() - interval '1 day' - interval '39 minutes'),
('G2d1_share1', 'alZaQcmUUQAt3TIFxLxwTmkw9cAp', 'gallery', 'share', NULL, now() - interval '1 day' - interval '38 minutes');


-- 2 dias atrás

INSERT INTO metrics_raw_events
(id, entity_id, entity_type, event_type, source, created_at)
VALUES
-- ===== PRODUTO 1 =====
('P1d2_a1', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'gallery', now() - interval '2 days' - interval '15 minutes'),
('P1d2_a2', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'feed', now() - interval '2 days' - interval '14 minutes'),
('P1d2_a3', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'search', now() - interval '2 days' - interval '13 minutes'),
('P1d2_a4', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'feed', now() - interval '2 days' - interval '12 minutes'),
('P1d2_a5', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'link', now() - interval '2 days' - interval '11 minutes'),

('P1d2_fav1', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'favorite', NULL, now() - interval '2 days' - interval '10 minutes'),
('P1d2_chat1', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'chat_opened', NULL, now() - interval '2 days' - interval '9 minutes'),
('P1d2_chat2', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'chat_message_sent', NULL, now() - interval '2 days' - interval '8 minutes'),

-- ===== PRODUTO 2 =====
('P2d2_v1', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'view', 'feed', now() - interval '2 days' - interval '25 minutes'),
('P2d2_v2', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'view', 'gallery', now() - interval '2 days' - interval '24 minutes'),
('P2d2_v3', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'view', 'search', now() - interval '2 days' - interval '23 minutes'),
('P2d2_fav1', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'favorite', NULL, now() - interval '2 days' - interval '22 minutes'),
('P2d2_fav2', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'favorite', NULL, now() - interval '2 days' - interval '21 minutes'),
('P2d2_chat1', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'chat_opened', NULL, now() - interval '2 days' - interval '20 minutes'),

-- ===== GALERIA 1 =====
('G1d2_v1', 'd6TGw8rvksb57BGhNYnet9ThqrRJ', 'gallery', 'view', NULL, now() - interval '2 days' - interval '35 minutes'),
('G1d2_v2', 'd6TGw8rvksb57BGhNYnet9ThqrRJ', 'gallery', 'view', NULL, now() - interval '2 days' - interval '34 minutes'),
('G1d2_share1', 'd6TGw8rvksb57BGhNYnet9ThqrRJ', 'gallery', 'share', NULL, now() - interval '2 days' - interval '33 minutes'),

-- ===== GALERIA 2 =====
('G2d2_v1', 'alZaQcmUUQAt3TIFxLxwTmkw9cAp', 'gallery', 'view', NULL, now() - interval '2 days' - interval '45 minutes'),
('G2d2_v2', 'alZaQcmUUQAt3TIFxLxwTmkw9cAp', 'gallery', 'view', NULL, now() - interval '2 days' - interval '44 minutes'),
('G2d2_share1', 'alZaQcmUUQAt3TIFxLxwTmkw9cAp', 'gallery', 'share', NULL, now() - interval '2 days' - interval '43 minutes');


-- 3 dias atrás 
INSERT INTO metrics_raw_events
(id, entity_id, entity_type, event_type, source, created_at)
VALUES
-- ===== PRODUTO 1 =====
('P1d3_a1', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'feed', now() - interval '3 days' - interval '18 minutes'),
('P1d3_a2', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'gallery', now() - interval '3 days' - interval '17 minutes'),
('P1d3_a3', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'search', now() - interval '3 days' - interval '16 minutes'),
('P1d3_a4', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'feed', now() - interval '3 days' - interval '15 minutes'),
('P1d3_a5', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'view', 'gallery', now() - interval '3 days' - interval '14 minutes'),

('P1d3_fav1', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'favorite', NULL, now() - interval '3 days' - interval '13 minutes'),
('P1d3_chat1', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'chat_opened', NULL, now() - interval '3 days' - interval '12 minutes'),
('P1d3_chat2', 'Mvm1t8GbA5xJ59OUzIbbCgHFpcD8', 'product', 'chat_message_sent', NULL, now() - interval '3 days' - interval '11 minutes'),

-- ===== PRODUTO 2 =====
('P2d3_v1', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'view', 'feed', now() - interval '3 days' - interval '28 minutes'),
('P2d3_v2', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'view', 'search', now() - interval '3 days' - interval '27 minutes'),
('P2d3_v3', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'view', 'gallery', now() - interval '3 days' - interval '26 minutes'),
('P2d3_fav1', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'favorite', NULL, now() - interval '3 days' - interval '25 minutes'),
('P2d3_fav2', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'favorite', NULL, now() - interval '3 days' - interval '24 minutes'),
('P2d3_chat1', 'dlqya6oc1FfVYiu285gc9G5mtlqV', 'product', 'chat_opened', NULL, now() - interval '3 days' - interval '23 minutes'),

-- ===== GALERIA 1 =====
('G1d3_v1', 'd6TGw8rvksb57BGhNYnet9ThqrRJ', 'gallery', 'view', NULL, now() - interval '3 days' - interval '50 minutes'),
('G1d3_v2', 'd6TGw8rvksb57BGhNYnet9ThqrRJ', 'gallery', 'view', NULL, now() - interval '3 days' - interval '49 minutes'),
('G1d3_share1', 'd6TGw8rvksb57BGhNYnet9ThqrRJ', 'gallery', 'share', NULL, now() - interval '3 days' - interval '48 minutes'),

-- ===== GALERIA 2 =====
('G2d3_v1', 'alZaQcmUUQAt3TIFxLxwTmkw9cAp', 'gallery', 'view', NULL, now() - interval '3 days' - interval '60 minutes'),
('G2d3_v2', 'alZaQcmUUQAt3TIFxLxwTmkw9cAp', 'gallery', 'view', NULL, now() - interval '3 days' - interval '59 minutes'),
('G2d3_share1', 'alZaQcmUUQAt3TIFxLxwTmkw9cAp', 'gallery', 'share', NULL, now() - interval '3 days' - interval '58 minutes');
