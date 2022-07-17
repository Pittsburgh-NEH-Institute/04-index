xquery version "3.1";
(:==========
Declare namespaces
===========:)
declare namespace hoax = "http://obdurodon.org/hoax";
declare namespace m = "http://www.obdurodon.org/model";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace html="http://www.w3.org/1999/xhtml";
(:==========
Declare global variables to path
==========:)
declare variable $exist:root as xs:string := 
    request:get-parameter("exist:root", "xmldb:exist:///db/apps");
declare variable $exist:controller as xs:string := 
    request:get-parameter("exist:controller", "/pr-app");
declare variable $path-to-data as xs:string := 
    $exist:root || $exist:controller || '/data';
(:==========
Declare variable
==========:)
declare variable $articles-coll as document-node()+ 
    := collection($path-to-data || '/hoax_xml');
declare variable $articles as element(tei:TEI)+ 
    := $articles-coll/tei:TEI[ft:query(., 'ghost')];

(:==========
Instead of using a controller to connect the pieces of the pipeline,
we'll declare a variable to hold that data, and then we'll pipe that into
our view code. The view code is an HTML section (see above, we added the HTML
namespace in line 14.

You can test this by going to http://localhost:8080/exist/apps/02-titles-no-controller/modules/titles.xql)
==========:)
declare variable $data as element(m:titles) :=
<m:titles>{
    for $article in $articles 
    return
        <m:title>{$article//tei:titleStmt/tei:title => util:expand()}</m:title>
}</m:titles>;

$data