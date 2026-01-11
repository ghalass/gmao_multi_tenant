/*
  Warnings:

  - You are about to drop the column `hrm_initial` on the `organe` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "organe" DROP COLUMN "hrm_initial",
ADD COLUMN     "initialHeureChassis" DOUBLE PRECISION DEFAULT 0;
