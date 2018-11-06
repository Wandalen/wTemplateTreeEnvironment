( function _TemplateTreeEnvironment_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../amapping/TemplateTreeEnvironment.s' );

}

//

var _ = _global_.wTools;
var Parent = wTester;

var tree =
{

  atomic1 : 'a1',
  atomic2 : 2,
  somePath : 'TemplateTreeEnvironment.test.s',

}

// --
// test
// --

function trivial( test )
{
  var self = this;
  var template = new wTemplateTreeEnvironment
  ({
    tree : tree,
    prefixSymbol : '{',
    postfixSymbol : '}',
    upSymbol : '.',
    rootDirPath : __dirname,
  });

  /* */

  var got = template.query( 'atomic1' );
  var expected = 'a1';
  test.identical( got,expected );

  var got = template.query( 'atomic2' );
  var expected = 2;
  test.identical( got,expected );

  var got = template.pathGet( '{somePath}' );
  var expected = _.path.normalize( __filename );
  test.identical( got,expected );

}

// --
// declare
// --

var Self =
{

  name : 'Tools/mid/TemplateTreeEnvironment',
  silencing : 1,

  tests :
  {

    trivial : trivial,

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
