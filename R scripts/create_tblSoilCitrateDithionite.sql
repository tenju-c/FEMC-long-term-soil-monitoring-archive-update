CREATE TABLE `tblSoilCitrateDithionite` ( 
  `fkSoilSampleID`  INT NOT NULL, 
  `enuLab`          VARCHAR(45) NOT NULL, 
  `fldFe_pct`       DECIMAL(6,3) DEFAULT NULL  COMMENT 'Dithionite-Citrate Fe %', 
  `fldAl_pct`       DECIMAL(6,3) DEFAULT NULL  COMMENT 'Dithionite-Citrate Al %', 
  `fldMn_pct`       DECIMAL(6,4) DEFAULT NULL  COMMENT 'Dithionite-Citrate Mn %', 
  PRIMARY KEY (`fkSoilSampleID`, `enuLab`), 
  CONSTRAINT `fk_tblSoilCitrateDithionite_tblSoilSample` 
    FOREIGN KEY (`fkSoilSampleID`) 
    REFERENCES `tblSoilSample` (`pkSoilSampleID`) 
    ON DELETE CASCADE ON UPDATE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 
  COMMENT='Citrate-dithionite extraction. Not comparable to Fe_pyro/Al_pyro/Mn_pyro.';