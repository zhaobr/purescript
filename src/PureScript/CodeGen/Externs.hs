-----------------------------------------------------------------------------
--
-- Module      :  PureScript.CodeGen.Externs
-- Copyright   :  (c) Phil Freeman 2013
-- License     :  MIT
--
-- Maintainer  :  Phil Freeman <paf31@cantab.net>
-- Stability   :  experimental
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module PureScript.CodeGen.Externs (
    externToPs
) where

import Data.List (intercalate)
import qualified Data.Map as M
import PureScript.Declarations
import PureScript.TypeChecker.Monad
import PureScript.CodeGen.Pretty.Types
import PureScript.CodeGen.Pretty.Kinds

externToPs :: Environment -> Declaration -> Maybe String
externToPs env (ValueDeclaration name _) = do
  (ty, _) <- M.lookup name $ names env
  return $ "extern " ++ show name ++ " :: " ++ prettyPrintPolyType ty
externToPs env (ExternDeclaration name ty) =
  return $ "extern " ++ show name ++ " :: " ++ prettyPrintPolyType ty
externToPs env (ExternDataDeclaration name kind) =
  return $ "extern data " ++ name ++ " :: " ++ prettyPrintKind kind
externToPs env (TypeSynonymDeclaration name args ty) =
  return $ "type " ++ name ++ " " ++ intercalate " " args ++ " = " ++ prettyPrintType ty
externToPs _ _ = Nothing
