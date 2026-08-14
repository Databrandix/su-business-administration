-- Remove faculty phone numbers.
--
-- These were personal mobile numbers for 10 of the 11 faculty, published
-- as tel: links on each public profile. Dropping the column deletes the
-- stored values along with the field, so the data cannot be re-exposed by
-- a future template change.
--
-- DESTRUCTIVE: the numbers are not recoverable from the database after
-- this runs.
ALTER TABLE "faculty" DROP COLUMN "phone";
