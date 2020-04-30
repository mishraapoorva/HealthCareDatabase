-- Create rules section -------------------------------------------------

--CREATE RULE [CheckRule1] AS 
--go

-- Create tables section -------------------------------------------------

-- Table treatment_catalog

USE Test;

CREATE TABLE [treatment_catalog]
(
 [treatment_name] Varchar(100) NOT NULL,
 [treatment_cost] Int NOT NULL
)
go

-- Add keys for table treatment_catalog

ALTER TABLE [treatment_catalog] ADD CONSTRAINT [PK_treatment_catalog] PRIMARY KEY ([treatment_name])
go

-- Table specialization

CREATE TABLE [specialization]
(
 [specialization] Varchar(20) NOT NULL,
 [doctor_id] Int NOT NULL
)
go

-- Add keys for table specialization

ALTER TABLE [specialization] ADD CONSTRAINT [PK_specialization] PRIMARY KEY ([doctor_id])
go

-- Table location_catalouge

CREATE TABLE [location_catalouge]
(
 [zip_code] Char(5) NOT NULL,
 [city] Varchar(20) NOT NULL,
 [county] Varchar(50) NOT NULL
)
go

-- Add keys for table location_catalouge

ALTER TABLE [location_catalouge] ADD CONSTRAINT [PK_location_catalouge] PRIMARY KEY ([zip_code])
go

-- Table doctor_license

CREATE TABLE [doctor_license]
(
 [license_number] Varchar(50) NOT NULL,
 [authority] Varchar(50) NOT NULL,
 [expiry_date] Date NOT NULL,
 [doctor_id] Int NOT NULL
)
go

-- Add keys for table doctor_license

ALTER TABLE [doctor_license] ADD CONSTRAINT [PK_doctor_license] PRIMARY KEY ([license_number],[doctor_id])
go

-- Table insurance

CREATE TABLE [insurance]
(
 [policy_number] Varchar(25) NOT NULL,
 [provider] Varchar(40) NOT NULL,
 [max_coverage] Money NOT NULL,
 [patient_id] Int NOT NULL,
 [begin_date] Date NOT NULL,
 [end_date] Date NOT NULL
)
go

-- Create indexes for table insurance

CREATE INDEX [IX_Relationship12] ON [insurance] ([patient_id])
go

-- Add keys for table insurance

ALTER TABLE [insurance] ADD CONSTRAINT [PK_insurance] PRIMARY KEY ([policy_number])
go

-- Table equipment

CREATE TABLE [equipment]
(
 [equipment_name] Varchar(20) NOT NULL,
 [maintenance_due_date] Date NOT NULL,
 [warranty_end_date] Date NOT NULL,
 [purchase_date] Date NOT NULL,
 [equipment_id] Int NOT NULL,
 [room_number] Varchar(6) NULL,
 [location_id] Varchar(6) NULL
)
go

-- Create indexes for table equipment

CREATE INDEX [IX_Relationship25] ON [equipment] ([room_number],[location_id])
go

-- Add keys for table equipment

ALTER TABLE [equipment] ADD CONSTRAINT [PK_equipment] PRIMARY KEY ([equipment_id])
go

-- Table prescription

CREATE TABLE [prescription]
(
 [medicine_name] Varchar(40) NOT NULL,
 [morning] Bit NOT NULL,
 [afternoon] Bit NOT NULL,
 [night] Bit NOT NULL,
 [duration] Smallint NOT NULL,
 [notes] Varchar(50) NULL,
 [appointment_id] Int NOT NULL,
 [patient_id] Int NOT NULL
)
go

-- Add keys for table prescription

ALTER TABLE [prescription] ADD CONSTRAINT [PK_prescription] PRIMARY KEY ([appointment_id],[medicine_name])
go

-- Table invoice

CREATE TABLE [invoice]
(
 [invoice_id] Int IDENTITY NOT NULL,
 [date] Datetime NOT NULL,
 [amount] Int NULL,
 [appointment_id] Int NOT NULL
)
go

-- Add keys for table invoice

ALTER TABLE [invoice] ADD CONSTRAINT [PK_invoice] PRIMARY KEY ([invoice_id],[appointment_id])
go

-- Table supplies

CREATE TABLE [supplies]
(
 [supplies_name] Varchar(30) NOT NULL,
 [no_of_units] Int NOT NULL,
 [cost_of_each_unit] Money NOT NULL,
 [location_id] Varchar(6) NOT NULL,
 [supply_id] Int NOT NULL
)
go

-- Create indexes for table supplies

CREATE INDEX [IX_Relationship26] ON [supplies] ([location_id])
go

-- Add keys for table supplies

ALTER TABLE [supplies] ADD CONSTRAINT [PK_supplies] PRIMARY KEY ([supply_id])
go

-- Table location

CREATE TABLE [location]
(
 [location_id] Varchar(6) NOT NULL,
 [addressline1] Varchar(200) NOT NULL,
 [addressline2] Varchar(150) NULL,
 [contact_number] Char(10) NOT NULL,
 [zip_code] Char(5) NOT NULL
)
go

-- Create indexes for table location

CREATE INDEX [IX_Relationship5] ON [location] ([zip_code])
go

-- Add keys for table location

ALTER TABLE [location] ADD CONSTRAINT [PK_location] PRIMARY KEY ([location_id])
go

-- Table room

CREATE TABLE [room]
(
 [room_number] Varchar(6) NOT NULL,
 [room_type] Varchar(45) NULL,
 [location_id] Varchar(6) NOT NULL
)
go

-- Add keys for table room

ALTER TABLE [room] ADD CONSTRAINT [PK_room] PRIMARY KEY ([room_number],[location_id])
go

-- Table patient

CREATE TABLE [patient]
(
 [patient_id] Int IDENTITY NOT NULL,
 [first_name] Varchar(20) NOT NULL,
 [middle_name] Varchar(20) NULL,
 [last_name] Varchar(30) NOT NULL,
 [contact_number] Char(10) NOT NULL,
 [date_of_birth] Date NOT NULL,
 [addressline1] Varchar(200) NOT NULL,
 [addressline2] Varchar(150) NULL,
 [zip_code] Char(5) NOT NULL,
 [emergency_contact_number] Char(10) NULL,
 [gender] Char(1) NULL,
 [email_address] Varchar(100) NOT NULL
)
go

-- Add keys for table patient

ALTER TABLE [patient] ADD CONSTRAINT [PK_patient] PRIMARY KEY ([patient_id])
go

-- Table treatment

CREATE TABLE [treatment]
(
 [treatment_cost] Int NOT NULL,
 [appointment_id] Int NOT NULL,
 [treatment_name] Varchar(100) NULL
)
go

-- Create indexes for table treatment

CREATE INDEX [IX_Relationship28] ON [treatment] ([treatment_name])
go

CREATE INDEX [IX_app can have treatment(s)] ON [treatment] ([appointment_id])

-- Table appointment

CREATE TABLE [appointment]
(
 [appointment_id] Int IDENTITY NOT NULL,
 [patient_id] Int NOT NULL,
 [status] Varchar(20) NOT NULL,
 [date] Date NOT NULL,
 [start_time] Time NOT NULL,
 [end_time] Time NOT NULL,
 [doctor_id] Int NULL,
 [room_number] Varchar(6) NULL,
 [location_id] Varchar(6) NULL
)
go

-- Create indexes for table appointment

CREATE INDEX [IX_patient makes an appointment] ON [appointment] ([patient_id])
go

CREATE INDEX [IX_Relationship24] ON [appointment] ([room_number],[location_id])
go

CREATE INDEX [IX_Relationship11] ON [appointment] ([doctor_id])
go

-- Add keys for table appointment

ALTER TABLE [appointment] ADD CONSTRAINT [PK_appointment] PRIMARY KEY ([appointment_id])
go

-- Table doctor

CREATE TABLE [doctor]
(
 [doctor_id] Int IDENTITY NOT NULL,
 [first_name] Varchar(20) NOT NULL,
 [middle_name] Varchar(20) NULL,
 [last_name] Varchar(30) NOT NULL,
 [contact_number] Char(10) NOT NULL,
 [doctor_photo] Image NULL,
 [email_address] Varchar(40) NOT NULL
)
go

-- Add keys for table doctor

ALTER TABLE [doctor] ADD CONSTRAINT [PK_doctor] PRIMARY KEY ([doctor_id])
go

-- Table doctor_schedule

CREATE TABLE [doctor_schedule]
(
 [slot1] Bit NOT NULL,
 [slot2] Bit NOT NULL,
 [slot3] Bit NOT NULL,
 [slot4] Bit NOT NULL,
 [slot5] Bit NOT NULL,
 [slot6] Bit NOT NULL,
 [slot7] Bit NOT NULL,
 [slot8] Bit NOT NULL,
 [date] Date NOT NULL,
 [doctor_id] Int NOT NULL
)
go

-- Add keys for table doctor_schedule

ALTER TABLE [doctor_schedule] ADD CONSTRAINT [PK_doctor_schedule] PRIMARY KEY ([doctor_id])
go

-- Table medical_history

CREATE TABLE [medical_history]
(
 [medications] Bit NULL,
 [patient_id] Int NOT NULL,
 [anaesthetic_allergy] Bit NULL,
 [other_allergies] Bit NULL
)
go

-- Create indexes for table medical_history

CREATE INDEX [IX_Relationship1] ON [medical_history] ([patient_id])
go

-- Add keys for table medical_history

ALTER TABLE [medical_history] ADD CONSTRAINT [PK_medical_history] PRIMARY KEY ([patient_id])
go

-- Table login

CREATE TABLE [login]
(
 [username] Varchar(30) NOT NULL,
 [password] Varchar(20) NOT NULL,
 [role] Varchar(20) NOT NULL,
 [doctor_id] Int NULL
)
go

-- Create indexes for table login

CREATE INDEX [IX_Relationship4] ON [login] ([doctor_id])
go

-- Add keys for table login

ALTER TABLE [login] ADD CONSTRAINT [PK_login] PRIMARY KEY ([username])
go

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE [treatment] ADD CONSTRAINT [treatment reference from treatment_catalog] FOREIGN KEY ([treatment_name]) REFERENCES [treatment_catalog] ([treatment_name]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [supplies] ADD CONSTRAINT [location has supplies] FOREIGN KEY ([location_id]) REFERENCES [location] ([location_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [equipment] ADD CONSTRAINT [room has equipment(s)] FOREIGN KEY ([room_number], [location_id]) REFERENCES [room] ([room_number], [location_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [appointment] ADD CONSTRAINT [appointment takes place in a room] FOREIGN KEY ([room_number], [location_id]) REFERENCES [room] ([room_number], [location_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [specialization] ADD CONSTRAINT [doctor has specialization(s)] FOREIGN KEY ([doctor_id]) REFERENCES [doctor] ([doctor_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [prescription] ADD CONSTRAINT [appointment has a prescription] FOREIGN KEY ([appointment_id]) REFERENCES [appointment] ([appointment_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [doctor_license] ADD CONSTRAINT [doctor has license(s)] FOREIGN KEY ([doctor_id]) REFERENCES [doctor] ([doctor_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [treatment] ADD CONSTRAINT [app can have treatment(s)] FOREIGN KEY ([appointment_id]) REFERENCES [appointment] ([appointment_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [insurance] ADD CONSTRAINT [patient has insurance(s)] FOREIGN KEY ([patient_id]) REFERENCES [patient] ([patient_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [invoice] ADD CONSTRAINT [each app generates invoice(s)] FOREIGN KEY ([appointment_id]) REFERENCES [appointment] ([appointment_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [appointment] ADD CONSTRAINT [patient can have many appointment(s)] FOREIGN KEY ([patient_id]) REFERENCES [patient] ([patient_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [medical_history] ADD CONSTRAINT [each patient has a medical history] FOREIGN KEY ([patient_id]) REFERENCES [patient] ([patient_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [login] ADD CONSTRAINT [every doctor will have a login] FOREIGN KEY ([doctor_id]) REFERENCES [doctor] ([doctor_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [location] ADD CONSTRAINT [one location reference can have multiple locations] FOREIGN KEY ([zip_code]) REFERENCES [location_catalouge] ([zip_code]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [doctor_schedule] ADD CONSTRAINT [every doctor will have schedule] FOREIGN KEY ([doctor_id]) REFERENCES [doctor] ([doctor_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [appointment] ADD CONSTRAINT [one doctor will have many appointments] FOREIGN KEY ([doctor_id]) REFERENCES [doctor] ([doctor_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [room] ADD CONSTRAINT [one location can have multiple rooms] FOREIGN KEY ([location_id]) REFERENCES [location] ([location_id]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

-------------------------------------------------------------------------------------------------------
/****** Object:  Index [IX_patient makes an appointment]    Script Date: 12/13/2019 12:57:10 AM ******/
CREATE NONCLUSTERED INDEX [IX_patient makes an appointment] ON [dbo].[appointment]
(
	[patient_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Relationship11]    Script Date: 12/13/2019 12:57:10 AM ******/
CREATE NONCLUSTERED INDEX [IX_Relationship11] ON [dbo].[appointment]
(
	[doctor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Relationship24]    Script Date: 12/13/2019 12:57:10 AM ******/
CREATE NONCLUSTERED INDEX [IX_Relationship24] ON [dbo].[appointment]
(
	[room_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Relationship25]    Script Date: 12/13/2019 12:57:10 AM ******/
CREATE NONCLUSTERED INDEX [IX_Relationship25] ON [dbo].[equipment]
(
	[room_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Relationship12]    Script Date: 12/13/2019 12:57:10 AM ******/
CREATE NONCLUSTERED INDEX [IX_Relationship12] ON [dbo].[insurance]
(
	[patient_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Relationship5]    Script Date: 12/13/2019 12:57:10 AM ******/
CREATE NONCLUSTERED INDEX [IX_Relationship5] ON [dbo].[location]
(
	[zip_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Relationship4]    Script Date: 12/13/2019 12:57:10 AM ******/
CREATE NONCLUSTERED INDEX [IX_Relationship4] ON [dbo].[login]
(
	[doctor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Relationship1]    Script Date: 12/13/2019 12:57:10 AM ******/
CREATE NONCLUSTERED INDEX [IX_Relationship1] ON [dbo].[medical_history]
(
	[patient_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_app can have treatment(s)]    Script Date: 12/13/2019 12:57:10 AM ******/
CREATE NONCLUSTERED INDEX [IX_app can have treatment(s)] ON [dbo].[treatment]
(
	[appointment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Relationship28]    Script Date: 12/13/2019 12:57:10 AM ******/
CREATE NONCLUSTERED INDEX [IX_Relationship28] ON [dbo].[treatment]
(
	[treatment_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[appointment]  WITH CHECK ADD  CONSTRAINT [appointment takes place in a room] FOREIGN KEY([room_number])
REFERENCES [dbo].[room] ([room_number])
GO
ALTER TABLE [dbo].[appointment] CHECK CONSTRAINT [appointment takes place in a room]
GO
ALTER TABLE [dbo].[appointment]  WITH CHECK ADD  CONSTRAINT [one doctor will have many appointments] FOREIGN KEY([doctor_id])
REFERENCES [dbo].[doctor] ([doctor_id])
GO
ALTER TABLE [dbo].[appointment] CHECK CONSTRAINT [one doctor will have many appointments]
GO
ALTER TABLE [dbo].[appointment]  WITH CHECK ADD  CONSTRAINT [patient can have many appointment(s)] FOREIGN KEY([patient_id])
REFERENCES [dbo].[patient] ([patient_id])
GO
ALTER TABLE [dbo].[appointment] CHECK CONSTRAINT [patient can have many appointment(s)]
GO
ALTER TABLE [dbo].[doctor_license]  WITH CHECK ADD  CONSTRAINT [doctor has license(s)] FOREIGN KEY([doctor_id])
REFERENCES [dbo].[doctor] ([doctor_id])
GO
ALTER TABLE [dbo].[doctor_license] CHECK CONSTRAINT [doctor has license(s)]
GO
ALTER TABLE [dbo].[doctor_schedule]  WITH CHECK ADD  CONSTRAINT [every doctor will have schedule] FOREIGN KEY([doctor_id])
REFERENCES [dbo].[doctor] ([doctor_id])
GO
ALTER TABLE [dbo].[doctor_schedule] CHECK CONSTRAINT [every doctor will have schedule]
GO
ALTER TABLE [dbo].[equipment]  WITH CHECK ADD  CONSTRAINT [room has equipment(s)] FOREIGN KEY([room_number])
REFERENCES [dbo].[room] ([room_number])
GO
ALTER TABLE [dbo].[equipment] CHECK CONSTRAINT [room has equipment(s)]
GO
ALTER TABLE [dbo].[insurance]  WITH CHECK ADD  CONSTRAINT [patient has insurance(s)] FOREIGN KEY([patient_id])
REFERENCES [dbo].[patient] ([patient_id])
GO
ALTER TABLE [dbo].[insurance] CHECK CONSTRAINT [patient has insurance(s)]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [each app generates invoice(s)] FOREIGN KEY([appointment_id])
REFERENCES [dbo].[appointment] ([appointment_id])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [each app generates invoice(s)]
GO
ALTER TABLE [dbo].[location]  WITH CHECK ADD  CONSTRAINT [one location reference can have multiple locations] FOREIGN KEY([zip_code])
REFERENCES [dbo].[location_catalouge] ([zip_code])
GO
ALTER TABLE [dbo].[location] CHECK CONSTRAINT [one location reference can have multiple locations]
GO
ALTER TABLE [dbo].[login]  WITH CHECK ADD  CONSTRAINT [every doctor will have a login] FOREIGN KEY([doctor_id])
REFERENCES [dbo].[doctor] ([doctor_id])
GO
ALTER TABLE [dbo].[login] CHECK CONSTRAINT [every doctor will have a login]
GO
ALTER TABLE [dbo].[medical_history]  WITH CHECK ADD  CONSTRAINT [each patient has a medical history] FOREIGN KEY([patient_id])
REFERENCES [dbo].[patient] ([patient_id])
GO
ALTER TABLE [dbo].[medical_history] CHECK CONSTRAINT [each patient has a medical history]
GO
ALTER TABLE [dbo].[prescription]  WITH CHECK ADD  CONSTRAINT [appointment has a prescription] FOREIGN KEY([appointment_id])
REFERENCES [dbo].[appointment] ([appointment_id])
GO
ALTER TABLE [dbo].[prescription] CHECK CONSTRAINT [appointment has a prescription]
GO
ALTER TABLE [dbo].[room]  WITH CHECK ADD  CONSTRAINT [one location can have multiple rooms] FOREIGN KEY([location_id])
REFERENCES [dbo].[location] ([location_id])
GO
ALTER TABLE [dbo].[room] CHECK CONSTRAINT [one location can have multiple rooms]
GO
ALTER TABLE [dbo].[specialization]  WITH CHECK ADD  CONSTRAINT [doctor has specialization(s)] FOREIGN KEY([doctor_id])
REFERENCES [dbo].[doctor] ([doctor_id])
GO
ALTER TABLE [dbo].[specialization] CHECK CONSTRAINT [doctor has specialization(s)]
GO
ALTER TABLE [dbo].[supplies]  WITH CHECK ADD  CONSTRAINT [location has supplies] FOREIGN KEY([location_id])
REFERENCES [dbo].[location] ([location_id])
GO
ALTER TABLE [dbo].[supplies] CHECK CONSTRAINT [location has supplies]
GO
ALTER TABLE [dbo].[tooth]  WITH CHECK ADD  CONSTRAINT [patient can have a tooth] FOREIGN KEY([patient_id])
REFERENCES [dbo].[patient] ([patient_id])
GO
ALTER TABLE [dbo].[tooth] CHECK CONSTRAINT [patient can have a tooth]
GO
ALTER TABLE [dbo].[treatment]  WITH CHECK ADD  CONSTRAINT [app can have treatment(s)] FOREIGN KEY([appointment_id])
REFERENCES [dbo].[appointment] ([appointment_id])
GO
ALTER TABLE [dbo].[treatment] CHECK CONSTRAINT [app can have treatment(s)]
GO
ALTER TABLE [dbo].[treatment]  WITH CHECK ADD  CONSTRAINT [treatment reference from reatment_catalog] FOREIGN KEY([treatment_name])
REFERENCES [dbo].[treatment_catalog] ([treatment_name])
GO
ALTER TABLE [dbo].[treatment] CHECK CONSTRAINT [treatment reference from reatment_catalog]
GO
ALTER TABLE [dbo].[appointment]  WITH CHECK ADD CHECK  (([date]>=getdate()))
GO
ALTER TABLE [dbo].[appointment]  WITH CHECK ADD CHECK  (([end_time]>[start_time]))
GO
ALTER TABLE [dbo].[doctor]  WITH CHECK ADD CHECK  (([contact_number] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[doctor]  WITH CHECK ADD CHECK  (([first_name] like '[A-Z]%'))
GO
ALTER TABLE [dbo].[doctor]  WITH CHECK ADD CHECK  (([last_name] like '[A-Z]%'))
GO
ALTER TABLE [dbo].[doctor]  WITH CHECK ADD CHECK  (([middle_name] like '[A-Z]%'))
GO
ALTER TABLE [dbo].[insurance]  WITH CHECK ADD CHECK  (([end_date]>[begin_date]))
GO
ALTER TABLE [dbo].[location]  WITH CHECK ADD CHECK  (([contact_number] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[location]  WITH CHECK ADD CHECK  (([zip_code] like '[0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[location_catalouge]  WITH NOCHECK ADD CHECK  (([county] like '[A-Z]%'))
GO
ALTER TABLE [dbo].[location_catalouge]  WITH NOCHECK ADD CHECK  (([zip_code] like '[0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[location_catalouge]  WITH NOCHECK ADD CHECK  (([city] like '[A-Z]%'))
GO
ALTER TABLE [dbo].[patient]  WITH CHECK ADD CHECK  (([contact_number] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[patient]  WITH CHECK ADD CHECK  (([email_address] like '%@%.%'))
GO
ALTER TABLE [dbo].[patient]  WITH CHECK ADD CHECK  (([emergency_contact_number] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[patient]  WITH CHECK ADD CHECK  (([first_name] like '[A-Z]%'))
GO
ALTER TABLE [dbo].[patient]  WITH CHECK ADD CHECK  (([gender]='M' OR [gender]='F'))
GO
ALTER TABLE [dbo].[patient]  WITH CHECK ADD CHECK  (([last_name] like '[A-Z]%'))
GO
ALTER TABLE [dbo].[patient]  WITH CHECK ADD CHECK  (([middle_name] like '[A-Z]%'))
GO
ALTER TABLE [dbo].[patient]  WITH CHECK ADD CHECK  (([zip_code] like '[0-9][0-9][0-9][0-9][0-9]'))
GO

---------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE  [dbo].[insertAppointmentRow]   
 @patient_id Int,
 @status Varchar(20) ,
 @room_number Smallint ,
 @date Date ,
 @start_time Time ,
 @end_time Time ,
 @doctor_id Int 
AS   
	IF     @patient_id IS NULL OR @status IS NULL OR @room_number IS NULL 
	     OR @date IS NULL OR @start_time IS NULL OR @end_time IS NULL OR @doctor_id IS NULL
		  raiserror ('Values cannot be null' , 16 , 16)
   
	ELSE
			INSERT INTO dbo.appointment( patient_id,status,room_number,date,start_time,end_time,doctor_id) 
			VALUES (    
		             @patient_id ,
					 @status ,
					 @room_number  ,
					 @date ,
					 @start_time ,
					 @end_time ,
					 @doctor_id )
GO

-------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[send_mail_db]
       @profile_name2 varchar(max), 
       @recipients2 varchar(max), 
       @body2 varchar(max), 
       @subject2 varchar(max) 
     AS 
     BEGIN   
         EXEC msdb.dbo.sp_send_dbmail  
			 @profile_name = @profile_name2,  
			 @recipients = @recipients2,  
			 @body =  @body2,  
             @subject = @subject2 ;
       END
GO

-----------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE  dbo.insertPatientRow   
 @patient_id Int ,
 @first_name Varchar(20),
 @middle_name Varchar(20) ,
 @last_name Varchar(30),
 @contact_number Char(10),
 @date_of_birth Date,
 @addressline1 Varchar(200) ,
 @addressline2 Varchar(150) ,
 @zip_code Char(5) ,
 @emergency_contact_number Char(10) ,
 @gender Char(1),
 @email_address Varchar(100) 
 AS   
	IF @patient_id IS NULL OR @first_name IS NULL OR  @last_name IS NULL OR @contact_number IS NULL OR 
	@date_of_birth IS NULL OR @addressline1 IS NULL OR @zip_code IS NULL OR @email_address IS NULL
	raiserror ('Values cannot be null' , 16 , 16)
	ELSE					 
			INSERT INTO [dbo].[patient]
           (patient_id,
 			first_name,
			middle_name,
			last_name ,
			contact_number,
			date_of_birth,
			addressline1,
			addressline2,
			zip_code,
			emergency_contact_number,
			gender,
			email_address)
     VALUES
           (@patient_id,
			@first_name,
			@middle_name,
			@last_name,
			@contact_number,
			@date_of_birth,
			@addressline1,
			@addressline2,
			@zip_code,
			@emergency_contact_number,
			@gender,
			@email_address)
GO
-----------------------------------------------------------------------------------------------------------
CREATE TRIGGER trg_doctor_schedule
ON appointment
AFTER INSERT
AS
BEGIN
DECLARE @doctor int
DECLARE @dateInserted Date
DECLARE @Slot varchar(20)
DECLARE @start_time time(7)
SELECT  @doctor = doctor_id FROM inserted
SELECT  @dateInserted = date FROM inserted
SELECT  @start_time = start_time FROM inserted


IF @start_time = '10:00:00.0000000'
    UPDATE doctor_schedule
	SET Slot1= 1
	where date = @dateInserted AND
	doctor_id =@doctor
ELSE IF @start_time = '10:30:00.0000000'
    UPDATE doctor_schedule
	SET Slot2= 1
	where date = @dateInserted AND
	doctor_id =@doctor
ELSE IF @start_time = '11:00:00.0000000'
    UPDATE doctor_schedule
	SET Slot3= 1
	where date = @dateInserted AND
	doctor_id =@doctor	
ELSE IF @start_time = '11:30:00.0000000'
    UPDATE doctor_schedule
	SET Slot4= 1
	where date = @dateInserted AND
	doctor_id =@doctor	
ELSE IF @start_time = '13:00:00.0000000'
    UPDATE doctor_schedule
	SET Slot5= 1
	where date = @dateInserted AND
	doctor_id =@doctor	
ELSE IF @start_time = '13:30:00.0000000'
    UPDATE doctor_schedule
	SET Slot6= 1
	where date = @dateInserted AND
	doctor_id =@doctor
ELSE IF @start_time = '14:00:00.0000000'
    UPDATE doctor_schedule
	SET Slot7= 1
	where date = @dateInserted AND
	doctor_id =@doctor
ELSE IF @start_time = '14:30:00.0000000'
    UPDATE doctor_schedule
	SET Slot8= 1
	where date = @dateInserted AND
	doctor_id =@doctor

END

---------------------------------------------------------------------------------------------------
CREATE FUNCTION getDoctorPatient (@appointment_id int)
RETURNS TABLE
AS
RETURN 
(

select b.first_name + ' ' + b.last_name as 'Doctor'  , b.contact_number , c.first_name + ' ' + c.last_name as 'Patient'  , c.contact_number as 'Con'
from appointment a
join doctor b ON
a.doctor_id = b.doctor_id
join patient c ON
a.doctor_id = b.doctor_id
where a.appointment_id = @appointment_id

);
GO
--------------------------------------------------------------------------------------------

CREATE VIEW appointment_schedule 
AS SELECT 
Doctor_id,
patient_id, 
date, 
start_time,
location_id 
FROM appointment
Go

--------------------------------------------------------------------------------------

CREATE VIEW supply_info AS
SELECT zip_code, contact_number, supply_id, no_of_units, supplies_name
FROM location
JOIN supplies
ON location.location_id = supplies.location_id
GO