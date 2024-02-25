/**
 * Written by Nguyen Ngoc Minh
 * Copyright by MyVietnam.net. All rights reserved.
 * Unauthorized use is prohibited.
 */
var menuTree = new Array();
var menuParent;
var menuOpenMenu;
var openMenuToRootPath = new Array();
var openMenuParentValues;

function buildMenu(treeArray, parentNode, openNode) {
    if (treeArray.length == 0) return;
    if (parentNode == null) parentNode = 0;
    if (openNode == null) openNode = 0;

    menuTree = treeArray;
    menuParent = parentNode;
    menuOpenMenu = openNode;
    if ( menuOpenMenu > 0 ) {
        openMenuParentValues = menuTree[getArrayId(menuOpenMenu)].split("||");
    }
    openMenuToRootPath = getOpenMenuToRootPath(openNode);

    drawMenu(parentNode);
}

function drawMenu(parentNode) {
    var values = menuTree[getArrayId(parentNode)].split("||");
    document.write("<table border='0' cellpadding='0' cellspacing='0' width='170'>");
    document.write("<tr>");
    if (menuOpenMenu == rootChannelId) {
      document.write("<td class='news_active_" +  1 + "' nowrap><a class='news_active_" +  1 + "' href='" + values[3] + "'>&nbsp;" + values[2] + "</a></td>");
    } else {
      document.write("<td class='news_deactive_" +  1 + "' nowrap><a class='news_deactive_" +  1 + "' href='" + values[3] + "'>&nbsp;" + values[2] + "</a></td>");
    }
    if (menuOpenMenu == rootChannelId) {
        document.write("<td class='news_active_" +  1 + "'><font color='Red'>&nbsp;</font></td>");
    } else {
        document.write("<td class='news_deactive_" +  1 + "'><font color='Red'>&nbsp;</font></td>");
    }
    document.write("</tr>");
    document.write("<tr><td class='breakline'></td></tr>");
    drawMenu_recursive(parentNode, 1);
    document.write("</table>");
}

function drawMenu_recursive(node, level) {
    var childs = getAllChilds(node);
    for (var i = 0; i < childs.length; i++) {
        var currentChild = childs[i];
        var values = menuTree[getArrayId(currentChild)].split("||");
        var currentParent = values[1];
        var styleClass = '';
        if (currentChild == menuOpenMenu) {
            if (level == 1) {
                styleClass = 'news_active_' + level;
            } else {
                styleClass = "submenu_" + (level+1);
            }
        } else if ( (values[1] /* current's parent */ == menuOpenMenu) ||
                    (values[1] /* current's parent */ == openMenuParentValues[1] && level > 1)) {
            styleClass = "submenu_" + (level+1);
        } else if (currentChild == openMenuParentValues[1]) {
            styleClass = 'news_active_' + level;
        } else {
            styleClass = 'news_deactive_' + level;
        }
        document.write("<tr class='" + styleClass + "'>");
        document.write("<td nowrap>&nbsp;");
        if ( level == 0) {
            document.write("&nbsp;&nbsp;");
        }
        for ( var j = 1; j < level ; j ++ ) {
            document.write("&nbsp;&nbsp;");
        }
        document.write("<a class='"+ styleClass + "' href='" + values[3] + "'>" + values[2] + "</a></td>");

        if ( currentChild == menuOpenMenu && level > 1) {
            document.write("<td class=\"redbold\">&laquo;</td>");
        } else {
            document.write("<td>&nbsp;</td>");
        }
        document.write("</tr>");
        document.write("<tr><td class='breakline'></td></tr>");

        if (isInThePath(currentChild)) {
            drawMenu_recursive(currentChild, level+1);
        }
    }//for
}
// Returns the position of a node in the array
function getArrayId(node) {
    for (var i = 0; i < menuTree.length; i++) {
        var nodeValues = menuTree[i].split("||");
        if (nodeValues[0] == node) return i;
    }
    return null;
}

function getOpenMenuToRootPath(openNode) {
    var ret = new Array();
    var currentIndex = 0;

    while (openNode != menuParent) {
        ret[currentIndex] = openNode;
        currentIndex++;
        if(currentIndex > 10) break;//avoid bad code, infinitive loop
        var arrayIndex = getArrayId(openNode);
        if (arrayIndex == null) break;
        var nodeValues = menuTree[arrayIndex].split("||");
        openNode = nodeValues[1];
    }
    return ret;
}

function isInThePath(node) {
    for (var i = 0; i < openMenuToRootPath.length; i++) {
        if (node == openMenuToRootPath[i]) return true;
    }
    return false;
}

function getAllChilds(parentNode) {
    var ret = new Array();
    var currentIndex = 0;
    for (var i = 0; i < menuTree.length; i++) {
        var nodeValues = menuTree[i].split("||");
        if (nodeValues[1] == parentNode) {
            ret[currentIndex] = nodeValues[0];
            currentIndex++;
        }
    }
    return ret;
}
