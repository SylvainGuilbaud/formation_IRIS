ROUTINE common [Type=INC]
#define sql(%Arg) set sql($i(sql))=%Arg
#define logcontent(%name,%type,%msg,%content) do ##class(common.trace).log(%name,%type,%msg,%content)
#define log(%name,%type,%msg) do ##class(common.trace).log(%name,%type,%msg)