CREATE TABLE `tblSoilParticleSize` ( 
  `fkSoilSampleID`    INT NOT NULL, 
  `fldClay`           DECIMAL(5,2) DEFAULT NULL, 
  `fldSilt`           DECIMAL(5,2) DEFAULT NULL, 
  `fldSand`           DECIMAL(5,2) DEFAULT NULL, 
  `fldFineSilt`       DECIMAL(5,2) DEFAULT NULL, 
  `fldCoarseSilt`     DECIMAL(5,2) DEFAULT NULL, 
  `fldVeryFineSand`   DECIMAL(5,2) DEFAULT NULL, 
  `fldFineSand`       DECIMAL(5,2) DEFAULT NULL, 
  `fldMediumSand`     DECIMAL(5,2) DEFAULT NULL, 
  `fldCoarseSand`     DECIMAL(5,2) DEFAULT NULL, 
  `fldVeryCoarseSand` DECIMAL(5,2) DEFAULT NULL, 
  PRIMARY KEY (`fkSoilSampleID`), 
  CONSTRAINT `fk_tblSoilParticleSize_tblSoilSample` 
    FOREIGN KEY (`fkSoilSampleID`) 
    REFERENCES `tblSoilSample` (`pkSoilSampleID`) 
    ON DELETE CASCADE ON UPDATE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;