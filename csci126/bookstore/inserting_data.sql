
-- Adding manufacturer names
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Canon');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Nikon');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Sony');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Polaroid');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Epson');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Sigma');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Panasonic');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('GoPro');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Olympus');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Fujifilm');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Kodak');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Casio');
INSERT INTO `photography`.`manufacturers` (`compName`) VALUES ('Other');

-- Adding lens
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('1', 'EF 8-15 mm  f/ 4 L USM Fisheye ');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('1', 'EF-S 10-18 mm f/ 4.5-5.6 IS STM');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('1', 'EF-S 10-22 mm  f/ 3.5-4.5 USM');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('1', 'EF-M 11-22 mm f/ 4-5.6 IS STM ');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('1', 'EF 14 mm f/ 2.8 L USM');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('6', 'AF 4.5mm F2.8 EX DC Circular Fisheye HSM');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('6', 'AF 8mm F3.5 EX DG Circular Fisheye');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('6', '10-20 mm f/ 3.5 EX DC HSM');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('6', 'AF 14 mm f/ 3.5');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('6', 'DG 15-30 mm f/ 3.5-4.5 EX Aspherical ');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('11', '80-210 mm f/ 4.5-5.6 ');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('2', 'Nikkor 6.7-13 mm f/ 3.5-5.6 VR');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('2', 'AF-S Nikkor 14-24 mm f/ 2.8 G ED');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('2', 'Nikkor 11-27.5 mm f/ 3.5–5.6 AW');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('2', 'Nikkor 11-27.5 mm f/ 3.5-5.6');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('2', 'Nikkor 10-100 mm f/ 4-5.6 VR');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('3', 'AF DT 11-18 mm  f/ 4.5-5.6 D');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('3', 'DT 16-50 mm f/ 2.8 SSM ');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('3', 'DT 18-135 mm f/ 3.5-5.6 SAM');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('9', 'ZUIKO DIGITAL ED 7-14 mm f/ 4');
INSERT INTO `photography`.`lens` (`companyID`, `model`) VALUES ('9', '9 mm f/ 8 Fisheye Body Cap Lens BCL-0980');

-- Adding cameras
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('1', 'EOS 60D');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('1', 'EOS 5D');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('1', 'EOS 7D');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('1', 'Power Shot SD40');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('1', 'IXUS 510 HS');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('7', 'Lumix DMC-ZS3');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('7', 'Lumix DMC-LZ10');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('11', 'EasyShare V705');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('11', 'LS420');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('2', 'D800');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('2', 'Coolpix S2');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('2', 'D40');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('3', 'Cybershot DSC T2');
INSERT INTO `photography`.`cameras` (`maker`, `model`) VALUES ('3', 'Alpha NEX-7');

-- Adding users
INSERT INTO `photography`.`users` (`username`) VALUES ('frankie');
INSERT INTO `photography`.`users` (`username`) VALUES ('ThroughMyLens');
INSERT INTO `photography`.`users` (`username`) VALUES ('DavidRuby');
INSERT INTO `photography`.`users` (`username`) VALUES ('Fork');
INSERT INTO `photography`.`users` (`username`) VALUES ('Spoon');
INSERT INTO `photography`.`users` (`username`) VALUES ('Leaper');
INSERT INTO `photography`.`users` (`username`) VALUES ('aza');
INSERT INTO `photography`.`users` (`username`) VALUES ('theNoob');
INSERT INTO `photography`.`users` (`username`) VALUES ('Hansen');
INSERT INTO `photography`.`users` (`username`) VALUES ('elison');

-- Adding pictures
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Yosemite Falls', '30', '2000-9-29', '6.0', '30.0', '1/100', '100', '5', '5');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Morro Bay', '38', '2014-1-9', '2.5', '27.3', '4/260', '3000', '12', '3');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Fresno', '29', '2010-11-26', '4.6', '24.5', '3/450', '6000', '3', '3');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `iso`, `ownerID`) VALUES ('Art of Downtown', '41', '2009-4-20', '400', '5');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `ownerID`) VALUES ('Noob Try', '36', '2015-3-19', '8');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Beautiful Flowers', '40', '2004-5-16', '5.0', '31.0', '1/350', '400', '12', '1');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Tulips', '40', '2004-5-16', '3.5', '20.0', '1/900', '600', '12', '1');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Sunflowers', '40', '2004-5-16', '4.0', '24.5', '3/800', '300', '12', '1');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Color Fields', '40', '2004-5-16', '5.0', '21.0', '1/200', '500', '12', '1');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('New Moon', '38', '2001-1-1', '3.0', '11.0', '1/500', '800', '16', '10');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Happy New Years', '38', '2001-1-1', '4.5', '15.0', '1/400', '100', '16', '10');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Kiss Me', '38', '2001-1-1', '3.5', '20.0', '1/300', '200', '16', '10');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `ownerID`) VALUES ('Family Vacation', '41', '2006-8-20', '7');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `ownerID`) VALUES ('Family Vacation', '41', '2006-8-20', '7');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `ownerID`) VALUES ('Family Vacation', '41', '2006-8-20', '7');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `ownerID`) VALUES ('Family Vacation', '41', '2006-8-21', '7');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `ownerID`) VALUES ('Family Vacation', '41', '2006-8-22', '7');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `ownerID`) VALUES ('Family Vacation', '41', '2006-8-22', '7');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Blueprints', '31', '2014-11-2', '3.0', '15.0', '1/700', '400', '1', '2');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Old Downtown', '31', '2014-9-13', '4.0', '25.0', '1/600', '300', '1', '2');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Delicious Pasta', '31', '2014-7-9', '1.0', '12.0', '1/200', '100', '1', '2');
INSERT INTO `photography`.`pictures` (`title`, `camera`, `date`, `aperture`, `focal`, `exposure`, `iso`, `lens`, `ownerID`) VALUES ('Testing My Lens', '31', '2014-2-14', '4.5', '30.0', '1/600', '2500', '1', '2');
