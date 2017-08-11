--sp_GetPropertiesDetailsSearch ' WHERE  spt.SpacetypeName=''Auditorium'' AND p.City=''San Diego'' AND  p.PostalCode=''92102''' ,'ASC'  
ALTER PROC sp_GetPropertiesDetailsSearch    
@query nvarchar(MAX), 
@orderBy nvarchar(500)   
    
AS                
BEGIN      
--SELECT  s.SpaceID,s.CustomerID,SpaceName,Occupancy,isnull(PrimaryImageFileName ,'') as PrimaryImageFileName,    
--(SELECT top 1 PropertyName from tblUFPProperties WHERE PropertyID=s.PropertyID  and City like '% '+@city +'%') as PropertyName,    
--(SELECT top 1 PropertyDescription from tblUFPProperties WHERE PropertyID=s.PropertyID) as PropertyDescription ,    
--(SELECT SpaceTypeName from tblUFPSpaceTypes WHERE SpaceTypeID=s.SpaceTypeID ) as SpaceTypeName,    
--(SELECT top 1 isnull( RatePerHour,'0.00'  )as RatePerHour from tblUFPPriceListDetailsSpaces WHERE SpaceID=s.SpaceID) as RatePerHour,                
--(SELECT top 1 AvailablePerHour from tblUFPPriceListDetailsSpaces WHERE SpaceID=s.SpaceID) as AvailablePerHour                
--from tblUFPSpaces as s     where  SpaceName=@facility     
    
    
DECLARE @sql nvarchar(4000)     
SET @sql='SELECT spt.SpaceTypeName,    
sp.SpaceID,    
sp.PropertyID,    
p.PropertyName,    
p.PrimaryImageFile,    
p.PropertyDescription,  
p.Latitude,  
p.Longitude,  
p.City,  
p.State,  
p.PostalCode,  
price.RatePerHour,
sp.SpaceDescription   
FROM tblUFPSpaceTypes spt    
INNER JOIN tblUFPSpaces sp ON sp.SpaceName=spt.SpaceTypeName    
INNER JOIN tblUFPProperties p ON p.PropertyID=sp.PropertyID    
INNER JOIN tblUFPPriceListDetailsSpaces price ON price.spaceid=sp.SpaceID ' + @query +'GROUP BY  spt.SpaceTypeName,sp.SpaceID,sp.PropertyID,p.PropertyName,p.PropertyDescription,p.Latitude,p.Longitude,p.City,p.State,p.PostalCode,price.RatePerHour,p.PrimaryImageFile,sp.SpaceDescription'    
    
IF @orderBy <> ''
BEGIN
set @sql=@sql + ' ORDER BY RatePerHour ' + @orderBy
END
--PRINT(@sql)    
EXEC(@sql)    
    
 END 