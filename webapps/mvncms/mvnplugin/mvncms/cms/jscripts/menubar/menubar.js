// Title: Tigra Menu
// Description: Free JavaScript Menu Navigation
// URL: http://www.javascript-menu.com/
// Version: 2.1 (commented source)
// Date: 06/26/2007
// Tech. Support: http://www.softcomplex.com/forum/forumdisplay_29/
// Notes: This script is free. Visit official site for further details.

// --------------------------------------------------------------------------------
// global collection containing all menus on current page
var A_MENUS = [];

// --------------------------------------------------------------------------------
// menu class
var rootWidth ;
var isRoot = false;
var rootItem;
var items = new Array();
var itemcount = 0;
function menu (a_items, a_tpl) {

	// browser check
	if (!document.body || !document.body.style)
		return;

	// store items structure
	this.a_config = a_items;

	// store template structure
	this.a_tpl = a_tpl;

	// get menu id
	this.n_id = A_MENUS.length;

	// declare collections
	this.a_index = [];
	this.a_children = [];

	// assigh methods and event handlers
	this.expand      = menu_expand;
	this.collapse    = menu_collapse;

	this.onclick     = menu_onclick;
	this.onmouseout  = menu_onmouseout;
	this.onmouseover = menu_onmouseover;
	this.onmousedown = menu_onmousedown;

	// default level scope description structure 
	this.a_tpl_def = {
		'block_top'  : 16,
		'block_left' : 16,
		'top'        : 20,
		'left'       : 4,
		'width'      : 120,
		'height'     : 22,
		'hide_delay' : 0,
		'expd_delay' : 0,
		'css'        : {
			'inner' : '',
			'outer' : ''
		}
	};
	
	// assign methods and properties required to imulate parent item
	this.getprop = function (s_key) {
		return this.a_tpl_def[s_key];
	};

	this.o_root = this;
	this.n_depth = -1;
	this.n_x = 0;
	this.n_y = 0;

	// 	init items recursively

//	document.write('<div style="display: inline; position: absolute; top: 77px; left: 35px; cursor: default;">');
	document.write('<table style="border:none;" cellpadding="0" cellspacing="0"> \n\t <tr>');
	for (n_order = 0; n_order < a_items.length; n_order++) {
		document.write('\n\n\n\n\n');
		document.write('<td valign="top">');
		isRoot = true;
		new menu_item(this, n_order);
//		alert("go here");
		if (document.getElementById(rootItem)) {
			document.getElementById(rootItem).style.width = rootWidth * 8;
		} else {
			alert('cannot get root item ' + rootItem);
		}
		//alert("rootWidth: "+rootWidth+ "items.length: "+items.length);
		if (items.length != 0) {
			for (var i = 0; i< items.length; i++) {
				if (document.getElementById(items[i])) {
					document.getElementById(items[i]).style.width = rootWidth * 8;
				} else {
					//alert('cannot get items from array');
				}
			}
		}
		rootWidth = 0;
		rootItem = null;
		items = new Array();
		itemcount = 0;
		document.write('</td>');
		document.write('\n\n\n\n\n');
	}
	document.write('</tr></table>');
//	document.write('</div');

	// register self in global collection
	A_MENUS[this.n_id] = this;

	// make root level visible
	for (var n_order = 0; n_order < this.a_children.length; n_order++)
		this.a_children[n_order].e_oelement.style.visibility = 'visible';
}

// --------------------------------------------------------------------------------
function menu_collapse (n_id) {
	// cancel item open delay
	clearTimeout(this.o_showtimer);

	// by default collapse to root level
	var n_tolevel = (n_id ? this.a_index[n_id].n_depth : 0);
	
	// hide all items over the level specified
	for (n_id = 0; n_id < this.a_index.length; n_id++) {
		var o_curritem = this.a_index[n_id];
		if (o_curritem.n_depth > n_tolevel && o_curritem.b_visible) {
			o_curritem.e_oelement.style.visibility = 'hidden';
//			o_curritem.e_oelement.style.zIndex = '0';
			o_curritem.b_visible = false;
		}
	}

	// reset current item if mouse has gone out of items
	if (!n_id)
		this.o_current = null;
}

// --------------------------------------------------------------------------------
function menu_expand (n_id) {

	// expand only when mouse is over some menu item
	if (this.o_hidetimer)
		return;

	// lookup current item
	var o_item = this.a_index[n_id];

	// close previously opened items
	if (this.o_current && this.o_current.n_depth >= o_item.n_depth)
		this.collapse(o_item.n_id);
	this.o_current = o_item;

	// exit if there are no children to open
	if (!o_item.a_children)
		return;

	// show direct child items
	for (var n_order = 0; n_order < o_item.a_children.length; n_order++) {
		var o_curritem = o_item.a_children[n_order];
		o_curritem.e_oelement.style.visibility = 'visible';
//		o_curritem.e_oelement.style.zIndex = '1';
		o_curritem.b_visible = true;
	}
}

// --------------------------------------------------------------------------------
function menu_onclick (n_id) {
	var o_item = this.a_index[n_id];
	var s_link = o_item.a_config[1];
	if (!s_link)
		return true;
	if (String(s_link).toLowerCase().indexOf('javascript:') == 0)
		return eval(s_link);
	if (o_item.a_config[2] && o_item.a_config[2]['tw'])
		window.open(s_link, o_item.a_config[2]['tw']);
	else
		window.location = s_link;
	return true;
}

// --------------------------------------------------------------------------------
function menu_onmouseout (n_id) {

	// lookup new item's object	
	var o_item = this.a_index[n_id];

	// apply rollout
	o_item.e_oelement.className = o_item.getstyle(0, 0);
	o_item.e_ielement.className = o_item.getstyle(1, 0);
	
	// update status line	
	o_item.upstatus(7);

	// run mouseover timer
	this.o_hidetimer = setTimeout('A_MENUS['+ this.n_id +'].collapse();',
		o_item.getprop('hide_delay'));
}

// --------------------------------------------------------------------------------
function menu_onmouseover (n_id) {

	// cancel mouseoute menu close and item open delay
	clearTimeout(this.o_hidetimer);
	this.o_hidetimer = null;
	clearTimeout(this.o_showtimer);

	// lookup new item's object	
	var o_item = this.a_index[n_id];

	// update status line	
	o_item.upstatus();

	// apply rollover
	o_item.e_oelement.className = o_item.getstyle(0, 1);
	o_item.e_ielement.className = o_item.getstyle(1, 1);
	
	// if onclick open is set then no more actions required
	if (o_item.getprop('expd_delay') < 0)
		return;

	// run expand timer
	this.o_showtimer = setTimeout('A_MENUS['+ this.n_id +'].expand(' + n_id + ');',
		o_item.getprop('expd_delay'));

}

// --------------------------------------------------------------------------------
// called when mouse button is pressed on menu item
// --------------------------------------------------------------------------------
function menu_onmousedown (n_id) {
	
	// lookup new item's object	
	var o_item = this.a_index[n_id];

	// apply mouse down style
	o_item.e_oelement.className = o_item.getstyle(0, 2);
	o_item.e_ielement.className = o_item.getstyle(1, 2);

	this.expand(n_id);
}

// --------------------------------------------------------------------------------
// menu item Class
function menu_item (o_parent, n_order) {

	// store parameters passed to the constructor
	this.n_depth  = o_parent.n_depth + 1;
	this.a_config = o_parent.a_config[n_order + (this.n_depth ? 3 : 0)];

	// return if required parameters are missing
	if (!this.a_config) return;

	// store info from parent item
	this.o_root    = o_parent.o_root;
	this.o_parent  = o_parent;
	this.n_order   = n_order;

	// register in global and parent's collections
	this.n_id = this.o_root.a_index.length;
	this.o_root.a_index[this.n_id] = this;
	o_parent.a_children[n_order] = this;

	// calculate item's coordinates
	var o_root = this.o_root,
		a_tpl  = this.o_root.a_tpl;

	// assign methods
	this.getprop  = mitem_getprop;
	this.getstyle = mitem_getstyle;
	this.upstatus = mitem_upstatus;

	this.n_x = n_order
		? o_parent.a_children[n_order - 1].n_x + this.getprop('left')
		: o_parent.n_x + this.getprop('block_left');

	this.n_y = n_order
		? o_parent.a_children[n_order - 1].n_y + this.getprop('top')
		: o_parent.n_y + this.getprop('block_top');

	if (isRoot) {
		rootWidth =	this.a_config[0].length;	
		rootItem = "e" + o_root.n_id + "_" + this.n_id + "o";
	} else {
		//rootItem = null;
	}
	// generate item's HMTL
	items[itemcount] = "e" + o_root.n_id + "_" + this.n_id + "o";
	itemcount ++;
//	alert(itemcount);
	document.write (
		'\n\t<div id="e', o_root.n_id, '_',	this.n_id, 'o" class="', this.getstyle(0, 0), '"', 
		(this.a_config[2] && this.a_config[2]['tt'] ? ' title="' + this.a_config[2]['tt'] + '"' : ''),
		' style="width: auto; height: auto; visibility:hidden;',
		' z-index: 0; cursor:', (this.a_config[1] ? 'pointer' : 'default'), '" ',
		'onclick="return A_MENUS[', o_root.n_id, '].onclick(', this.n_id,
		');" onmouseout="A_MENUS[', o_root.n_id, '].onmouseout(', this.n_id,
		');" onmouseover="A_MENUS[', o_root.n_id, '].onmouseover(',
		this.n_id, ');" onmousedown="A_MENUS[', o_root.n_id, '].onmousedown(',
		this.n_id, ');">\n\t\t<div id="e', o_root.n_id, '_',
		this.n_id, 'i" class="' ,this.getstyle(1, 0), '">',
		this.a_config[0], "</div>\n\t</div>\n"
	);
	
	if (rootWidth < this.a_config[0].length) {
		rootWidth = this.a_config[0].length;
	}

	this.e_ielement = document.getElementById('e' + o_root.n_id + '_' + this.n_id + 'i');
	this.e_oelement = document.getElementById('e' + o_root.n_id + '_' + this.n_id + 'o');

	this.b_visible = !this.n_depth;

	// no more initialization if leaf
	if (this.a_config.length < 4)
		return;

	isRoot = false;
	// node specific methods and properties
	this.a_children = [];

	// init downline recursively
	for (var n_order = 0; n_order < this.a_config.length - 3; n_order++) {
		new menu_item(this, n_order);
	}
}

// --------------------------------------------------------------------------------
// reads property from template file, inherits from parent level if not found
// ------------------------------------------------------------------------------------------
function mitem_getprop (s_key) {

	// check if value is defined for current level
	var s_value = null,
		a_level = this.o_root.a_tpl[this.n_depth];

	// return value if explicitly defined
	if (a_level)
		s_value = a_level[s_key];

	// request recursively from parent levels if not defined
	return (s_value == null ? this.o_parent.getprop(s_key) : s_value);
}
// --------------------------------------------------------------------------------
// reads property from template file, inherits from parent level if not found
// ------------------------------------------------------------------------------------------
function mitem_getstyle (n_pos, n_state) {

	var a_css = this.getprop('css');
	var a_oclass = a_css[n_pos ? 'inner' : 'outer'];

	// same class for all states	
	if (typeof(a_oclass) == 'string')
		return a_oclass;

	// inherit class from previous state if not explicitly defined
	for (var n_currst = n_state; n_currst >= 0; n_currst--)
		if (a_oclass[n_currst])
			return a_oclass[n_currst];
}

// ------------------------------------------------------------------------------------------
// updates status bar message of the browser
// ------------------------------------------------------------------------------------------
function mitem_upstatus (b_clear) {
	window.setTimeout("window.status=unescape('" + (b_clear
		? ''
		: (this.a_config[2] && this.a_config[2]['sb']
			? escape(this.a_config[2]['sb'])
			: escape(this.a_config[0]) + (this.a_config[1]
				? ' ('+ escape(this.a_config[1]) + ')'
				: ''))) + "')", 10);
}

// --------------------------------------------------------------------------------
// that's all folks
