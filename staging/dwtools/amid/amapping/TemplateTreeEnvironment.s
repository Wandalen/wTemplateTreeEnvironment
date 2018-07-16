( function _TemplateTreeEnvironment_s_( ) {

'use strict'; /**/

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
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

  _.include( 'wTemplateTreeResolver' );

}

//

var _global = _global_;
var _ = _global_.wTools;
var Parent = wTemplateTreeResolver;
var Self = function wTemplateTreeEnvironment( o )
{
  if( !( this instanceof Self ) )
  if( o instanceof Self )
  return o;
  else
  return new( _.routineJoin( Self, Self, arguments ) );
  return Self.prototype.init.apply( this,arguments );
}

Self.nameShort = 'TemplateTreeEnvironment';

// --
// inter
// --

function init( o )
{
  var self = this;

  Parent.prototype.init.call( self,o );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( self.constructor === Self )
  Object.preventExtensions( self );

}

//

function valueTry( name,def )
{
  var self = this;
  var name2 = name;

  if( self.front !== null )
  name2 = _.entitySelect
  ({
    container : self.front,
    query : name,
  });

  var result = self.resolveTry( name2 );

  /* console.log( 'REMINDER : optimize valueTry' ); */

  _.assert( arguments.length === 1 || def !== undefined, 'def should not be undefined if used' );
  _.assert( arguments.length === 1 || arguments.length === 2, 'valueTry expects 1 or 2 arguments' );

  if( result === undefined )
  result = def;

  if( self.verbosity )
  logger.debug( 'value :',name,'->',result );

  return result;
}

//

function valueGet( name )
{
  var self = this;
  var result = self.valueTry( name );

  _.assert( arguments.length === 1,'valueGet expects 1 argument' );

  if( result === undefined )
  {
    debugger;
    throw _.err( 'Unknown variable',name );
  }

  return result;
}

//

function pathTry( name,def )
{
  var self = this;
  var result;

  if( def !== undefined )
  result = self.valueTry( name,def );
  else
  result = self.valueTry( name );

  _.assert( arguments.length === 1 || arguments.length === 2,'pathTry expects 1 or 2 arguments' );

  if( !result )
  return def;

  result = _.pathJoin( self.rootDirPath,result );
  result = _.pathNormalize( result );

  if( self.verbosity )
  logger.debug( 'path :',name,'->',result );

  return result;
}

//

function pathGet( name )
{
  var self = this;
  var result = self.pathTry( name );

  if( result === undefined )
  {
    debugger;
    throw _.err( 'Unknown variable',name );
  }

  return result;
}

//

function pathsNormalize( name )
{
  var self = this;

  for( var t in self.tree )
  {
    var src = self.tree[ t ];
    if( !_.strEnds( t,'Path' ) )
    continue;
    if( !_.strIs( src ) )
    continue;
    self.tree[ t ] = self.pathGet( src );
  }

  return self;
}

// --
// relationships
// --

var Composes =
{
  verbosity : 0,
  rootDirPath : '',
}

var Associates =
{
  front : null,
}

var Restricts =
{
}

// --
// define class
// --

var Proto =
{

  init : init,

  valueTry : valueTry,
  valueGet : valueGet,
  value : valueGet,

  pathTry : pathTry,
  pathGet : pathGet,
  path : pathGet,

  pathsNormalize : pathsNormalize,

  // relationships

  constructor : Self,
  Composes : Composes,
  Associates : Associates,
  Restricts : Restricts,

};

// define

_.classMake
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

//

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

_[ Self.nameShort ] = _global_[ Self.name ] = Self;
if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
