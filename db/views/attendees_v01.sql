SELECT
  id::text,
  first_name, last_name, email,
  diet, songs, notes, NULL as child,
  updated_at
FROM guests
WHERE attending

UNION ALL

SELECT
  guest_id || '-' || plus_ones.id AS id,
  plus_ones.first_name, plus_ones.last_name, NULL AS email,
  plus_ones.diet, NULL as songs, NULL as notes, plus_ones.child,
  plus_ones.updated_at
FROM plus_ones
JOIN guests ON plus_ones.guest_id = guests.id
WHERE guests.attending
