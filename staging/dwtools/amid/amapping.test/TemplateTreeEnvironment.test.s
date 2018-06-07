( function _TemplateTreeEnvironment_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );/*hhh*/
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wTesting' );
  _.include( 'wPath' );
  require( '../amapping/TemplateTreeEnvironment.s' );

}

//

var _ = _global_.wTools;
var Parent = _.Tester;

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
  var expected = _.pathNormalize( __filename );
  test.identical( got,expected );

}

// --
// proto
// --

var Self =
{

  name : 'TemplateTreeEnvironment',
  // verbosity : 1,

  tests :
  {

    trivial : trivial,

  },

};

//

Self = wTestSuit( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
