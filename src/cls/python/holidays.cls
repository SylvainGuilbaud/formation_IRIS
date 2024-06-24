Class python.holidays Extends %RegisteredObject
{

/// Description
ClassMethod isPublicHoliday(check) As %Status [ Language = python ]
{
from datetime import date
import holidays

us_holidays = holidays.US()  # this is a dict-like object
# the below is the same, but takes a string:
us_holidays = holidays.country_holidays('US')  # this is a dict-like object

nyse_holidays = holidays.NYSE()  # this is a dict-like object
# the below is the same, but takes a string:
nyse_holidays = holidays.financial_holidays('NYSE')  # this is a dict-like object

date(2015, 1, 1) in us_holidays  # True
date(2015, 1, 2) in us_holidays  # False
us_holidays.get('2014-01-01')  # "New Year's Day"

fr_holidays = holidays.FR()  # this is a dict-like object
return check in fr_holidays
}

}
