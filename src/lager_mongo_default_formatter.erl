-module(lager_mongo_default_formatter).

-export([format/1, format/2]).

-spec format(Message::lager_msg:lager_msg(), any()) -> bson:document().
format(Message, _Config) -> format(Message).

-spec format(Message::lager_msg:lager_msg()) -> bson:document().
format(Message) ->
    {M, S, _} = lager_msg:timestamp(Message),
    Metadata = lager_msg:metadata(Message),
    {<<"level">>, lager_msg:severity(Message),
     <<"time">>, M * 1000000 + S,
     <<"node">>, node(),
     <<"msg">>, list_to_binary(lager_msg:message(Message)),
     <<"_module">>, atom_to_binary(proplists:get_value(module, Metadata), latin1),
     <<"_line">>, proplists:get_value(line, Metadata, 0)}.
