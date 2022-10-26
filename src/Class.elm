module Class exposing
    ( classTokens
    , applyIf
    )

{-| Create class name attribute from list of string, conditionally.


# Make `class` attribute

@docs classTokens


# Apply a token conditionally

@docs applyIf

-}

import Html exposing (Attribute)
import Html.Attributes exposing (class)


{-| -}
classTokens : List String -> Attribute msg
classTokens tokens =
    tokens
        |> List.filterMap
            (\tok ->
                case String.trim tok of
                    "" ->
                        Nothing

                    v ->
                        Just v
            )
        |> String.join " "
        |> class


{-| -}
applyIf : Bool -> String -> String
applyIf flag className =
    if flag then
        className

    else
        ""
