SELECT 
Stroke
,PREDICT(StrokeModel use StrokeModelTrained) as predicition
,PROBABILITY(StrokeModel USE StrokeModelTrained) as PROBABILITY
,*
from stroke_eval
order by PROBABILITY DESC