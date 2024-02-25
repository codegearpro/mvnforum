/* $Id: utils.js,v 1.7 2007/10/01 07:59:19 xuantl Exp $ */
function Validate_String(string, return_invalid_chars) {
  valid_chars = '1234567890-_.^~abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  invalid_chars = '';
  if(string == null || string == '')
     return(true);

  //For every character on the string.   
  for(index = 0; index < string.length; index++) {
    char = string.substr(index, 1);                        
     
    //Is it a valid character?
    if(valid_chars.indexOf(char) == -1) {
      //If not, is it already on the list of invalid characters?
      if(invalid_chars.indexOf(char) == -1) {
        //If it's not, add it.
        if(invalid_chars == '')
          invalid_chars += char;
        else
          invalid_chars += ', ' + char;
      }
    }
  }
            
  //If the string does not contain invalid characters, the function will return true.
  //If it does, it will either return false or a list of the invalid characters used
  //in the string, depending on the value of the second parameter.
  if(return_invalid_chars == true && invalid_chars != '') {
    last_comma = invalid_chars.lastIndexOf(',');
    if(last_comma != -1)
      invalid_chars = invalid_chars.substr(0, $last_comma) + 
      ' and ' + invalid_chars.substr(last_comma + 1, invalid_chars.length);
    return(invalid_chars);
    }
  else
    return(invalid_chars == ''); 
}

function Validate_Email_Address(email_address) {
  //Assumes that valid email addresses consist of user_name@domain.tld
  at = email_address.indexOf('@');
  dot = email_address.indexOf('.');

  if(at == -1 || 
    dot == -1 || 
    dot <= at + 1 ||
    dot == 0 || 
    dot == email_address.length - 1)
    return(false);
     
  user_name = email_address.substr(0, at);
  domain_name = email_address.substr(at + 1, email_address.length);                  

  if(Validate_String(user_name) === false || 
    Validate_String(domain_name) === false)
    return(false);                     

  return(true);
}

function focus_clear(e, text) {
  if (e.value == text) {
    e.value = '';
    return false;
  }
}

function lostfocus_default(e, text) {
  if (e.value == '') {
    e.value = text;
    return false;
  }
}

function ShowHide(id1, id2) {
  if (id1 != "") {
    toggleview(id1);
  }
  if (id2 != "") {
    toggleview(id2);
  }
}
function my_getbyid(id) {
  itm = null;
  if (document.getElementById) {
    itm = document.getElementById(id);
  } else {
    if (document.all) {
      itm = document.all[id];
    } else {
      if (document.layers) {
        itm = document.layers[id];
      }
    }
  }
  return itm;
}
function toggleview(id) {
  if (!id) {
    return;
  }
  if (itm = my_getbyid(id)) {
    if (itm.style.display == "none") {
      my_show_div(itm);
    } else {
      my_hide_div(itm);
    }
  }
}
function my_hide_div(itm) {
  if (!itm) {
    return;
  }
  itm.style.display = "none";
}
function my_show_div(itm) {
  if (!itm) {
    return;
  }
  itm.style.display = "";
}

function __Open(url){
  showDialog(url, 350, 250);
}

function __Open(url, w, h){
  showDialog(url, w, h);
}

function showDialog(url, width, height) {
  return showWindow(url, false, true , true , false , false , false , true , true , width , height , 0 , 0);
}

function showWindow(url, isStatus, isResizeable, isScrollbars, isToolbar, isLocation, isFullscreen, isTitlebar, isCentered, width, height, top, left) {
  if (isCentered) {
    top = (screen.height - height) / 2;
    left = (screen.width - width) / 2;
  }

  open(url, 'Result', 'status=' + (isStatus ? 'yes' : 'no') + ','
  + 'resizable=' + (isResizeable ? 'yes' : 'no') + ','
  + 'scrollbars=' + (isScrollbars ? 'yes' : 'no') + ','
  + 'toolbar=' + (isToolbar ? 'yes' : 'no') + ','
  + 'location=' + (isLocation ? 'yes' : 'no') + ','
  + 'fullscreen=' + (isFullscreen ? 'yes' : 'no') + ','
  + 'titlebar=' + (isTitlebar ? 'yes' : 'no') + ','
  + 'height=' + height + ',' + 'width=' + width + ','
  + 'top=' + top + ',' + 'left=' + left);
}
function doSaveAs() {
  if (document.execCommand) {
    document.execCommand("SaveAs")
  } else {
    alert("Save-feature available only in Internet Exlorer 5.x.")
  }
}
function slideshow(cdsTemplate, albumid, albumitemid) {
  window.open(cdsTemplate + '/viewalbum?albumid=' + albumid + '&albumitemid=' + albumitemid, 'album', 'width=800,height=635');
}