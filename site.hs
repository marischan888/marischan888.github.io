--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Text.Pandoc()
import           Data.Monoid()
import           Hakyll
--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
    -- copy static files to destination for reuse
    match "static/*/*" $ do
        route   idRoute
        compile copyFileCompiler
    
    match "pages/*/*" $ version "meta" $ do
        route idRoute
        compile getResourceBody

    match "pages/**" $ do
        route $
            gsubRoute "pages/" (const "") `composeRoutes` setExtension "html"
        compile $ do
            postList <- loadAll ("pages/projects/*" .&&. hasVersion "meta")
            let projectsCtx = listField "projects" siteCtx (return postList) <> siteCtx
            bloList <- loadAll ("pages/blogs/*" .&&. hasVersion "meta")
            let blogsCtx = listField "blogs" siteCtx (return bloList) <> siteCtx
            let combineCtx = mconcat [projectsCtx, blogsCtx]
            getResourceBody
                >>= applyAsTemplate projectsCtx
                >>= renderPandoc
                >>= loadAndApplyTemplate "templates/main.html"    projectsCtx
                >>= loadAndApplyTemplate "templates/default.html" combineCtx
                >>= relativizeUrls

    -- HTML templates like footer, head, etc.
    match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------
-- Normal Site Context
siteCtx :: Context String
siteCtx =
  constField "site_description"  "maris chen | portfolio"
    <> constField "site_title"        "maris chen | portfolio"
    <> constField "github_username"   "marischan888"
    <> constField "linkedin_username" "qianlin-chen"
    <> constField "email_username"    "chenq84"
    <> constField "email_domain"      "mcmaster"
    <> constField "email_tld"         "ca"
    <> defaultContext

-- Display
config :: Configuration
config = defaultConfiguration
  {
    destinationDirectory = "docs"
  }