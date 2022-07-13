xquery version "3.1";

(:~ This library module contains XQSuite tests for the 04-index app.
 :
 : @author djbpitt
 : @version 1.0.0
 : @see http://www.obdurodon.org
 :)

module namespace tests = "http://www.obdurodon.org/hoax/apps/04-index/tests";

declare namespace test="http://exist-db.org/xquery/xqsuite";



declare
    %test:name('one-is-one')
    %test:assertTrue
    function tests:tautology() {
        1 = 1
};
