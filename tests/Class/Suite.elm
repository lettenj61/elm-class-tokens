module Class.Suite exposing (..)

import Class
import Fuzz
import Html
import Test exposing (describe, fuzz, test, Test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector


suite : Test
suite =
    describe "Class module"
        [ test "simple example" <|
            \_ ->
                let
                    className =
                        Class.classTokens
                            [ "hello"
                            , "world"
                            ]

                    html =
                        Html.div
                            [ className
                            ]
                            []
                in
                Query.fromHtml html
                    |> Query.has
                        [ Selector.classes [ "hello", "world" ]
                        ]

        , fuzz (Fuzz.list <| Fuzz.asciiStringOfLengthBetween 2 20) "ascii input" <|
            \tokens ->
                let
                    -- Since `fuzz` generates whitespace, we should normalize the value
                    expectedClassOutcome =
                        tokens
                            |> List.map (String.trim)
                            |> List.filter (not << String.isEmpty)
                            |> String.join " "
                            |> String.split " "

                    className =
                        Class.classTokens tokens
                in
                Html.div [ className ] []
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.classes expectedClassOutcome
                        ]
        ]