module Types where

import Data.Aeson
import Data.Text ( Text )
import GHC.Generics

data Registration
  = Registration
    { registerName :: Text
    , registerEmail :: Text
    , registerBgGeneral :: Text
    , registerQuestions :: Text
    }
  deriving (Eq, Generic, FromJSON, ToJSON)

data RegistrationRes
  = RegistrationRes
    { registerStatus :: RegisterStatus
    }
  deriving (Eq, Generic, ToJSON)

data RegisterStatus
  = RegisterOk
  | RegisterNotOk
  deriving (Eq, Generic)

instance ToJSON RegisterStatus where
  toJSON x = case x of
    RegisterOk -> "ok"
    RegisterNotOk -> "notok"
