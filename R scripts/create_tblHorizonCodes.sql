CREATE TABLE `tblHorizonCodes` ( 

  `fldHorizonCode`   VARCHAR(45) NOT NULL, 

  `fldSampleType`    VARCHAR(2) NOT NULL COMMENT 'H or D', 

  `fldDescription`   TEXT, 

  `fldNotes`         TEXT, 

  PRIMARY KEY (`fldHorizonCode`, `fldSampleType`) 

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3; 

  