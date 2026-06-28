# Form Field Mapping

Hand-kept contract between the Google Form (legacy), the Prisma `Report` model /
shared zod schema (`packages/shared/src/reportSchema.ts`), and the Flutter local
schema (Drift). Update all three together when a field changes.

| # | Google Form Label | Type | Prisma / zod field | Dart field (Drift) |
|---|---|---|---|---|
| — | (form metadata) | uuid | `clientId` | `clientId` |
| 1 | Reporting month | dropdown | `reportingMonth` (DateTime, first-of-month) | `reportingMonth` |
| 2 | Community/District | text | `community` | `community` |
| 3 | Submitted by (Name and Position) | text | `submittedByName`, `submittedByPosition` | `submittedByName`, `submittedByPosition` |
| 4 | Date Submitted | date | `dateSubmitted` | `dateSubmitted` |
| 5 | Total number of Pregnant women this month | number | `pregnantWomenCount` | `pregnantWomenCount` |
| 6 | Total number of Deliveries conducted this month | number | `deliveriesTotal` | `deliveriesTotal` |
| 6a | At Health Facility | number | `deliveriesAtFacility` | `deliveriesAtFacility` |
| 6b | At Home | number | `deliveriesAtHome` | `deliveriesAtHome` |
| 7 | Total number of Maternal Deaths this month | number | `maternalDeaths` | `maternalDeaths` |
| 8 | Place of Death | checkbox (multi) | `placeOfDeath` (`PlaceOfDeath[]`) | `placeOfDeath` (comma-joined enum list) |
| 8a | (Other note) | text | `placeOfDeathOtherNote` | `placeOfDeathOtherNote` |
| 9 | Suspected Cause(s) | text | `suspectedMaternalCause` | `suspectedMaternalCause` |
| 10 | Total number of live births this month | number | `liveBirths` | `liveBirths` |
| 11 | Total number of infant deaths (0-12 months) | number | `infantDeathsTotal` | `infantDeathsTotal` |
| 11a | A. Within 24 hours | number | `infantDeathsWithin24h` | `infantDeathsWithin24h` |
| 11b | B. Within 1 month | number | `infantDeathsWithin1Month` | `infantDeathsWithin1Month` |
| 11c | C. Within 0-12 months | number | `infantDeathsWithin12Months` | `infantDeathsWithin12Months` |
| 12 | Suspected cause(s) of infant death | checkbox (multi) | `infantDeathCauses` (`InfantDeathCause[]`) | `infantDeathCauses` (comma-joined enum list) |
| 12a | (Other note) | text | `infantDeathCausesOtherNote` | `infantDeathCausesOtherNote` |
| 13 | A. Key challenges faced this month | paragraph | `keyChallenges` | `keyChallenges` |
| 14 | B. Actions taken/planned | paragraph | `actionsTaken` | `actionsTaken` |
| 15 | C. Additional comments/Suggestions | paragraph | `additionalComments` | `additionalComments` |

Sync metadata fields (`clientCreatedAt`, `clientUpdatedAt`, `serverReceivedAt`,
`serverUpdatedAt`, `origin`) and the `submittedById` relation are not part of the
original form — they exist purely to support the offline-sync/dedup design (see
the plan doc) and are not user-facing form fields.
