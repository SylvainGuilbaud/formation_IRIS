/// Abstract persistent superclass for AccountHolder
Class FCE.PersistentPerson Extends (%Persistent, FCE.Person) [ Abstract, NoExtent ]
{

Index NameIndex On Name;

Index EmailIndex On Email [ Unique ];

}
