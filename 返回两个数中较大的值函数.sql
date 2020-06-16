-->函数：返回两个数中值较大的数

CREATE FUNCTION F_GetMax
(   
  @arg1   AS   int,   
  @arg2   AS   int   
)   
RETURNS   int   
AS    
BEGIN   
  RETURN CASE   
           WHEN @arg1>=@arg2 THEN @arg1   
           WHEN @arg1<@arg2 THEN  @arg2   
           ELSE   NULL   
         END   
END   