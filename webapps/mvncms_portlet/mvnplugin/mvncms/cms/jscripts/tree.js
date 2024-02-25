// Arrays for nodes and icons
var nodes		= new Array();;
var openNodes	= new Array();
var icons		= new Array(6);
var changeToRoot = "changeCurrentChannel(0, 'Channel Root');";

// Loads all icons that are used in the tree
function preloadIcons() {
  icons[0] = new Image();
  icons[0].src = imageDir + "plus.gif";
  icons[1] = new Image();
  icons[1].src = imageDir + "plusbottom.gif";
  icons[2] = new Image();
  icons[2].src = imageDir + "minus.gif";
  icons[3] = new Image();
  icons[3].src = imageDir + "minusbottom.gif";
  icons[4] = new Image();
  icons[4].src = imageDir + "folder.gif";
  icons[5] = new Image();
  icons[5].src = imageDir + "folderopen.gif";
}
// Create the tree
function createTree(arrName, startNode, openNode) {
  nodes = arrName;
  if (nodes.length > 0) {
    preloadIcons();
    if (startNode == null) startNode = 0;
    if (openNode != 0 || openNode != null) setOpenNodes(openNode);

    if (startNode !=0) {
      var nodeValues = nodes[getArrayId(startNode)].split("|");
      document.write("<a  href=\"" + nodeValues[3] + "\" onclick=\"" + nodeValues[4] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img border='0' src=\"" + imageDir + "folderopen.gif\" align=\"absbottom\" alt=\"\" border=\"0\" />" + nodeValues[2] + "</a><br />");
    } else {
      document.write("<a  href=\"" + "#" + "\" onclick=\"" + changeToRoot + "\" onmouseover=\"window.status='Root Channel';return true;\" onmouseout=\"window.status=' ';return true;\">");
      document.write("<img border='0' src=\"" + imageDir + "base.gif\" align=\"absbottom\" alt=\"\" />Root Channel");
      document.write("</a><br />");
    }
    var recursedNodes = new Array();
    addNode(startNode, recursedNodes);
  }
}
// Returns the position of a node in the array
function getArrayId(node) {
  for (i=0; i<nodes.length; i++) {
    var nodeValues = nodes[i].split("|");
    if (nodeValues[0]==node) return i;
  }
}
// Puts in array nodes that will be open
function setOpenNodes(openNode) {
  for (i=0; i<nodes.length; i++) {
    var nodeValues = nodes[i].split("|");
    if (nodeValues[0]==openNode) {
      openNodes.push(nodeValues[0]);
      setOpenNodes(nodeValues[1]);
    }
  }
}
// Checks if a node is open
function isNodeOpen(node) {
  for (i=0; i<openNodes.length; i++)
    if (openNodes[i]==node) return true;
  return false;
}
// Checks if a node has any children
function hasChildNode(parentNode) {
  for (i=0; i< nodes.length; i++) {
    var nodeValues = nodes[i].split("|");
    if (nodeValues[1] == parentNode) return true;
  }
  return false;
}
// Checks if a node is the last sibling
function lastSibling (node, parentNode) {
  var lastChild = 0;
  for (i=0; i< nodes.length; i++) {
    var nodeValues = nodes[i].split("|");
    if (nodeValues[1] == parentNode)
      lastChild = nodeValues[0];
  }
  if (lastChild==node) return true;
  return false;
}
// Adds a new node in the tree
function addNode(parentNode, recursedNodes) {
  for (var i = 0; i < nodes.length; i++) {

    var nodeValues = nodes[i].split("|");
    if (nodeValues[1] == parentNode) {

      var ls	= lastSibling(nodeValues[0], nodeValues[1]);
      var hcn	= hasChildNode(nodeValues[0]);
      var ino = isNodeOpen(nodeValues[0]);

      // Write out line & empty icons
      for (g=0; g<recursedNodes.length; g++) {
        if (recursedNodes[g] == 1) document.write("<img border='0' src=\"" + imageDir + "line.gif\" align=\"absbottom\" alt=\"\" class= />");
        else  document.write("<img border='0' src=\"" + imageDir + "empty.gif\" align=\"absbottom\" border=\"0\" alt=\"\" />");
      }

      // put in array line & empty icons
      if (ls) recursedNodes.push(0);
      else recursedNodes.push(1);

      // Write out join icons
      if (hcn) {
        if (ls) {
          document.write("<a href=\"javascript: oc(" + nodeValues[0] + ", 1);\"><img border='0' id=\"join" + nodeValues[0] + "\" src=\"" + imageDir);
          if (ino) document.write("minus");
          else document.write("plus");
          document.write("bottom.gif\" align=\"absbottom\" alt=\"Open/Close node\" /></a>");
        } else {
          document.write("<a href=\"javascript: oc(" + nodeValues[0] + ", 0);\"><img border='0' id=\"join" + nodeValues[0] + "\" src=\"" + imageDir);
          if (ino) document.write("minus");
          else document.write("plus");
          document.write(".gif\" align=\"absbottom\" alt=\"Open/Close node\" /></a>");
        }
      } else {
        if (ls) document.write("<img border='0' src=\"" + imageDir + "join.gif\" align=\"absbottom\" alt=\"\" />");
        else document.write("<img border='0' src=\"" + imageDir + "joinbottom.gif\" align=\"absbottom\" alt=\"\" />");
      }

      // Start link
      document.write("<a href=\"" + nodeValues[3] + "\" onclick=\"" + nodeValues[4] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\">");

      // Write out folder & page icons
      if (hcn) {
        document.write("<img border='0' id=\"icon" + nodeValues[0] + "\" src=\"" + imageDir + "folder")
        if (ino) document.write("open");
        document.write(".gif\" align=\"absbottom\" alt=\"Folder\" />");
      } else document.write("<img border='0' id=\"icon" + nodeValues[0] + "\" src=\"" + imageDir + "page.gif\" align=\"absbottom\" alt=\"Page\" />");

      // Write out node name
      document.write(nodeValues[2]);

      // End link
      document.write("</a><br />");

      // If node has children write out divs and go deeper
      if (hcn) {
        document.write("<div id=\"div" + nodeValues[0] + "\"");
        if (!ino) document.write(" style=\"display: none;\"");
        document.write(">");
        addNode(nodeValues[0], recursedNodes);
        document.write("</div>");
      }
      // remove last line or empty icon
      recursedNodes.pop();
    }
  }
}
// Opens or closes a node
function oc(node, bottom) {
  var theDiv = document.getElementById("div" + node);
  var theJoin	= document.getElementById("join" + node);
  var theIcon = document.getElementById("icon" + node);

  if (theDiv.style.display == 'none') {
    if (bottom==1) theJoin.src = icons[3].src;
    else theJoin.src = icons[2].src;
    theIcon.src = icons[5].src;
    theDiv.style.display = '';
  } else {
    if (bottom==1) theJoin.src = icons[1].src;
    else theJoin.src = icons[0].src;
    theIcon.src = icons[4].src;
    theDiv.style.display = 'none';
  }
}
// Push and pop not implemented in IE(crap!    don´t know about NS though)
if(!Array.prototype.push) {
  function array_push() {
    for(var i=0;i<arguments.length;i++)
      this[this.length]=arguments[i];
    return this.length;
  }
  Array.prototype.push = array_push;
}

if(!Array.prototype.pop) {
  function array_pop(){
    lastElement = this[this.length-1];
    this.length = Math.max(this.length-1,0);
    return lastElement;
  }
  Array.prototype.pop = array_pop;
}

//Notice: these javascript functions are for handling taxonomy pages.
function checkAllCheckboxes() {
  var arrayElement = document.getElementsByTagName("input");
  document.getElementById("checkboxParams").value = "&";
  for (var i=0; i< arrayElement.length; i++) {

    if (( arrayElement[i] != null)) {
      if (arrayElement[i].getAttribute("id") != null ) {
          if (arrayElement[i].getAttribute("id").indexOf("checkAddContent") != -1) {
            if (arrayElement[i].checked) {
              var st = arrayElement[i].getAttribute("id");
              if (st.indexOf("_") == -1) {
                document.getElementById("checkboxParams").value = document.getElementById("checkboxParams").value + document.getElementById("Hidden").value + "&";
              } else {
                document.getElementById("checkboxParams").value = document.getElementById("checkboxParams").value + document.getElementById("Hidden_" + st.substring(16)).value + "&";
              }
            } else {
            
            }
          }
       }
    }
  }
  
}

function checkAllViewOptions() {
  var arrayElement = document.getElementsByTagName("select");
  document.getElementById("viewOptionParams").value = "&";

  for (var i=0; i< arrayElement.length; i++) {

    if (( arrayElement[i] != null)) {
      if (arrayElement[i].getAttribute("id") != null ) {
          if (arrayElement[i].getAttribute("id").indexOf("viewOptionList") != -1) {
          
            var st = arrayElement[i].getAttribute("id");
            if (st.indexOf("_") == -1) {
              document.getElementById("viewOptionParams").value = document.getElementById("viewOptionParams").value + document.getElementById("Hidden").value + "_" + arrayElement[i].value + "&";
            } else {
              document.getElementById("viewOptionParams").value = document.getElementById("viewOptionParams").value + document.getElementById("Hidden_" + st.substring(15)).value + "_" + arrayElement[i].value + "&";              
            }
            alert(document.getElementById("viewOptionParams").value);
          }
       }
    }
  }

}
  
//For AddContent Page
function handleFilterTaxonomyWithChannel(currentChannelID) {

  if (currentChannelID == 0) {
    document.getElementById("chooseTaxonomy").style.display = 'none';
  } else {
    var arrayElement = document.getElementsByTagName("option");

    document.getElementById("chooseTaxonomy").style.display = '';
    
    for (var i=0; i< arrayElement.length; i++) {
      if (( arrayElement[i] != null)) {
        if(arrayElement[i].value.indexOf("_") != -1) {
          // taxonomyID_channelID
          var myValue = arrayElement[i].value;
          taxonomyID = myValue.substring(0, myValue.indexOf("_"));
          channelID = myValue.substring(myValue.indexOf("_") + 1);
          if (channelID == currentChannelID || channelID == 0) {
            arrayElement[i].style.display = '';
          } else {
            arrayElement[i].style.display = 'none';
          }
        }
      }
    }
  }
}

function findCurrentFormID() {
  var currentForm = 0;
  //maximum upload files : 10
  for (var i = 0; i < 10; i++ ) {
    if (document.forms[i] != null) {
      currentForm = i;
    }
  }
  return currentForm;
}

function findImageNameHidden() {
  var field = "imageNameHidden";
  for (var i = 0; i < 10; i++ ) {
    if (document.forms[i] != null) {
      if (i > 1) {
        field = "imageNameHidden_" + (i - 2);
      }  
    }
  }
  return document.getElementById(field).value; 
}