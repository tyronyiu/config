SELECT DISTINCT 
Art.ArtNr AS 'artNr', 
Art.ArtID AS 'id'

FROM APS.dbo.Art 

LEFT JOIN 
          Obj
ON        Art.ObjID = Obj.ObjID  



/*SEARCH FOR ALL WITHOUT ANYTHING*/

WHERE Obj.Fmt != '7'
AND Obj.Fmt != '2'
AND Obj.Fmt != '15'
AND Art.Lock = '0'
/* 
WHERE Obj.Fmt != '14' 
AND Obj.Fmt != '2' 
*/



/* 
FMT (FORMAT ?) LIST 
-------- 
6 = BMP 
7 = JPG 
2 = RTF 
15 = PDF 
14 = ??? 
*/
