<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('DB_NAME') );

/** MySQL database username */
define( 'DB_USER', getenv('DB_USER') );

/** MySQL database password */
define( 'DB_PASSWORD', getenv('DB_PASSWORD') );

/** MySQL hostname */
define( 'DB_HOST', getenv('DB_HOST') );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'f}jf`b!?$[[ehI*$MV&AUBAyH`IS7yajql<H*`{%U.;sEB]p.zDxw(PfvtA-DYDQ' );
define( 'SECURE_AUTH_KEY',  'X{a:6^U:u<in[Hv`+:Y<_G;]<}TapdQJ-?(P}N?{~CRAJdsa?yf`](~[j9N<;pI9' );
define( 'LOGGED_IN_KEY',    'v}Oo:+fZ={*_RS{]n7=r; fwq%ukQE56IC]0_e0pYD<r[*K>!CX;o8{s4yEaj5pw' );
define( 'NONCE_KEY',        'GLO)Du:p{/wgIrvlXV}=sym#:mPbkbnS{4Zx:(4Hly?]1H}<,3]N6JN@V,`+^o!T' );
define( 'AUTH_SALT',        ')tjdCP%>P|ZT;:Rt;[]m5nL/B~h.u2DqY@:v$+dj_t<7*iG.H0yk*;@6b){]epXA' );
define( 'SECURE_AUTH_SALT', 'JSxrpKV?kYPTL-+t<UE8~7J@~0Nvc`~C5VjQ,m&y I&F+83Q=Kd.7C<vq$i)$QQ#' );
define( 'LOGGED_IN_SALT',   '34ho+5,H?{ T[,;k_lBXb)d@9ku3dtxO>z,hq%V{0e!#8:c|dhf]-@tgsPlw6:Z3' );
define( 'NONCE_SALT',       '}gH$~LM2QpKD]m,R.-]dp72f1~:UE[eFW:gEO8)>lh6lfR@TXK`@JTFpK~IqDRMx' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );