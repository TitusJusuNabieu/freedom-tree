-- CreateTable
CREATE TABLE "EducationSurvey" (
    "id" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "enumeratorName" TEXT NOT NULL,
    "surveyDate" TIMESTAMP(3) NOT NULL,
    "communityOrSchool" TEXT NOT NULL,
    "district" TEXT NOT NULL,
    "respondentName" TEXT NOT NULL,
    "respondentCategory" TEXT NOT NULL,
    "sex" TEXT NOT NULL,
    "answers" JSONB NOT NULL,
    "submittedById" TEXT NOT NULL,
    "origin" "SyncOrigin" NOT NULL DEFAULT 'MOBILE',
    "clientCreatedAt" TIMESTAMP(3) NOT NULL,
    "clientUpdatedAt" TIMESTAMP(3) NOT NULL,
    "serverReceivedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "serverUpdatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "EducationSurvey_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MaternalHealthSurvey" (
    "id" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "enumeratorName" TEXT NOT NULL,
    "surveyDate" TIMESTAMP(3) NOT NULL,
    "community" TEXT NOT NULL,
    "healthFacility" TEXT,
    "district" TEXT NOT NULL,
    "respondentName" TEXT NOT NULL,
    "respondentCategory" TEXT NOT NULL,
    "sex" TEXT NOT NULL,
    "answers" JSONB NOT NULL,
    "submittedById" TEXT NOT NULL,
    "origin" "SyncOrigin" NOT NULL DEFAULT 'MOBILE',
    "clientCreatedAt" TIMESTAMP(3) NOT NULL,
    "clientUpdatedAt" TIMESTAMP(3) NOT NULL,
    "serverReceivedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "serverUpdatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MaternalHealthSurvey_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "EducationSurvey_clientId_key" ON "EducationSurvey"("clientId");

-- CreateIndex
CREATE INDEX "EducationSurvey_surveyDate_idx" ON "EducationSurvey"("surveyDate");

-- CreateIndex
CREATE INDEX "EducationSurvey_communityOrSchool_idx" ON "EducationSurvey"("communityOrSchool");

-- CreateIndex
CREATE INDEX "EducationSurvey_respondentCategory_idx" ON "EducationSurvey"("respondentCategory");

-- CreateIndex
CREATE UNIQUE INDEX "MaternalHealthSurvey_clientId_key" ON "MaternalHealthSurvey"("clientId");

-- CreateIndex
CREATE INDEX "MaternalHealthSurvey_surveyDate_idx" ON "MaternalHealthSurvey"("surveyDate");

-- CreateIndex
CREATE INDEX "MaternalHealthSurvey_community_idx" ON "MaternalHealthSurvey"("community");

-- CreateIndex
CREATE INDEX "MaternalHealthSurvey_respondentCategory_idx" ON "MaternalHealthSurvey"("respondentCategory");

-- AddForeignKey
ALTER TABLE "EducationSurvey" ADD CONSTRAINT "EducationSurvey_submittedById_fkey" FOREIGN KEY ("submittedById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MaternalHealthSurvey" ADD CONSTRAINT "MaternalHealthSurvey_submittedById_fkey" FOREIGN KEY ("submittedById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
