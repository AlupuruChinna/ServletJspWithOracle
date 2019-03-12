<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
 <%!
 	static int loc=1,loc1=1;
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>inbox</title>
<style>
	ul[role="tree"] {
  margin: 0;
  padding: 20;
  list-style: none;
  font-size: 120%;
  width: 90%;
}

[role="treeitem"].doc:before {
    content: url(../images/file.png);
}

[role="treeitem"][aria-expanded="false"] > ul {
  display: none;
}

[role="treeitem"][aria-expanded="true"] > ul {
  display: block;
}

[role="treeitem"][aria-expanded="false"] > span:before {
  content: url(../images/closed.png);
}

[role="treeitem"][aria-expanded="true"] > span:before {
  content: url(../images/open.png);
}

[role="treeitem"],
[role="treeitem"] span {
  width: auto;
  margin: 0;
  padding: 0;
  border: 2px transparent solid;
  padding: 0.125em;
  display: block;
}

/* disable default keyboard focus styling for treeitems
   Keyboard focus is styled with the following CSS */
[role="treeitem"]:focus {
  outline: 0;
}


[role="treeitem"].focus,
[role="treeitem"] span.focus {
  border-color: black;
  background-color: #EEEEEE;
}

[role="treeitem"].hover,
[role="treeitem"] span:hover {
  background-color: #DDDDDD;
}
	

</style>

<script>
var Treeitem = function (node, treeObj, group) {

	  // Check whether node is a DOM element
	  if (typeof node !== 'object') {
	    return;
	  }

	  node.tabIndex = -1;
	  this.tree = treeObj;
	  this.groupTreeitem = group;
	  this.domNode = node;
	  this.label = node.textContent.trim();

	  if (node.getAttribute('aria-label')) {
	    this.label = node.getAttribute('aria-label').trim();
	  }

	  this.isExpandable = false;
	  this.isVisible = false;
	  this.inGroup = false;

	  if (group) {
	    this.inGroup = true;
	  }

	  var elem = node.firstElementChild;

	  while (elem) {

	    if (elem.tagName.toLowerCase() == 'ul') {
	      elem.setAttribute('role', 'group');
	      this.isExpandable = true;
	      break;
	    }

	    elem = elem.nextElementSibling;
	  }

	  this.keyCode = Object.freeze({
	    RETURN: 13,
	    SPACE: 32,
	    PAGEUP: 33,
	    PAGEDOWN: 34,
	    END: 35,
	    HOME: 36,
	    LEFT: 37,
	    UP: 38,
	    RIGHT: 39,
	    DOWN: 40
	  });
	};

	Treeitem.prototype.init = function () {
	  this.domNode.tabIndex = -1;

	  if (!this.domNode.getAttribute('role')) {
	    this.domNode.setAttribute('role', 'treeitem');
	  }

	  this.domNode.addEventListener('keydown', this.handleKeydown.bind(this));
	  this.domNode.addEventListener('click', this.handleClick.bind(this));
	  this.domNode.addEventListener('focus', this.handleFocus.bind(this));
	  this.domNode.addEventListener('blur', this.handleBlur.bind(this));

	  if (!this.isExpandable) {
	    this.domNode.addEventListener('mouseover', this.handleMouseOver.bind(this));
	    this.domNode.addEventListener('mouseout', this.handleMouseOut.bind(this));
	  }
	};

	Treeitem.prototype.isExpanded = function () {

	  if (this.isExpandable) {
	    return this.domNode.getAttribute('aria-expanded') === 'true';
	  }

	  return false;

	};

	/* EVENT HANDLERS */

	Treeitem.prototype.handleKeydown = function (event) {

	  var tgt = event.currentTarget,
	    flag = false,
	    char = event.key,
	    clickEvent;

	  function isPrintableCharacter (str) {
	    return str.length === 1 && str.match(/\S/);
	  }

	  function printableCharacter (item) {
	    if (char == '*') {
	      item.tree.expandAllSiblingItems(item);
	      flag = true;
	    }
	    else {
	      if (isPrintableCharacter(char)) {
	        item.tree.setFocusByFirstCharacter(item, char);
	        flag = true;
	      }
	    }
	  }

	  if (event.altKey || event.ctrlKey || event.metaKey) {
	    return;
	  }

	  if (event.shift) {
	    if (isPrintableCharacter(char)) {
	      printableCharacter(this);
	    }
	  }
	  else {
	    switch (event.keyCode) {
	      case this.keyCode.SPACE:
	      case this.keyCode.RETURN:
	        // Create simulated mouse event to mimic the behavior of ATs
	        // and let the event handler handleClick do the housekeeping.
	        try {
	          clickEvent = new MouseEvent('click', {
	            'view': window,
	            'bubbles': true,
	            'cancelable': true
	          });
	        }
	        catch (err) {
	          if (document.createEvent) {
	            // DOM Level 3 for IE 9+
	            clickEvent = document.createEvent('MouseEvents');
	            clickEvent.initEvent('click', true, true);
	          }
	        }
	        tgt.dispatchEvent(clickEvent);
	        flag = true;
	        break;

	      case this.keyCode.UP:
	        this.tree.setFocusToPreviousItem(this);
	        flag = true;
	        break;

	      case this.keyCode.DOWN:
	        this.tree.setFocusToNextItem(this);
	        flag = true;
	        break;

	      case this.keyCode.RIGHT:
	        if (this.isExpandable) {
	          if (this.isExpanded()) {
	            this.tree.setFocusToNextItem(this);
	          }
	          else {
	            this.tree.expandTreeitem(this);
	          }
	        }
	        flag = true;
	        break;

	      case this.keyCode.LEFT:
	        if (this.isExpandable && this.isExpanded()) {
	          this.tree.collapseTreeitem(this);
	          flag = true;
	        }
	        else {
	          if (this.inGroup) {
	            this.tree.setFocusToParentItem(this);
	            flag = true;
	          }
	        }
	        break;

	      case this.keyCode.HOME:
	        this.tree.setFocusToFirstItem();
	        flag = true;
	        break;

	      case this.keyCode.END:
	        this.tree.setFocusToLastItem();
	        flag = true;
	        break;

	      default:
	        if (isPrintableCharacter(char)) {
	          printableCharacter(this);
	        }
	        break;
	    }

	  }

	  if (flag) {
	    event.stopPropagation();
	    event.preventDefault();
	  }
	};

	Treeitem.prototype.handleClick = function (event) {
	  if (this.isExpandable) {
	    if (this.isExpanded()) {
	      this.tree.collapseTreeitem(this);
	    }
	    else {
	      this.tree.expandTreeitem(this);
	    }
	    event.stopPropagation();
	  }
	  else {
	    this.tree.setFocusToItem(this);
	  }
	};

	Treeitem.prototype.handleFocus = function (event) {
	  var node = this.domNode;
	  if (this.isExpandable) {
	    node = node.firstElementChild;
	  }
	  node.classList.add('focus');
	};

	Treeitem.prototype.handleBlur = function (event) {
	  var node = this.domNode;
	  if (this.isExpandable) {
	    node = node.firstElementChild;
	  }
	  node.classList.remove('focus');
	};

	Treeitem.prototype.handleMouseOver = function (event) {
	  event.currentTarget.classList.add('hover');
	};

	Treeitem.prototype.handleMouseOut = function (event) {
	  event.currentTarget.classList.remove('hover');
	};
</script>

<script>
window.addEventListener('load', function () {

	  var trees = document.querySelectorAll('[role="tree"]');

	  for (var i = 0; i < trees.length; i++) {
	    var t = new Tree(trees[i]);
	    t.init();
	  }

	});
	

var Tree = function (node) {
  // Check whether node is a DOM element
  if (typeof node !== 'object') {
    return;
  }

  this.domNode = node;

  this.treeitems = [];
  this.firstChars = [];

  this.firstTreeitem = null;
  this.lastTreeitem = null;

};

Tree.prototype.init = function () {

  function findTreeitems (node, tree, group) {

    var elem = node.firstElementChild;
    var ti = group;

    while (elem) {

      if (elem.tagName.toLowerCase() === 'li') {
        ti = new Treeitem(elem, tree, group);
        ti.init();
        tree.treeitems.push(ti);
        tree.firstChars.push(ti.label.substring(0, 1).toLowerCase());
      }

      if (elem.firstElementChild) {
        findTreeitems(elem, tree, ti);
      }

      elem = elem.nextElementSibling;
    }
  }

  // initialize pop up menus
  if (!this.domNode.getAttribute('role')) {
    this.domNode.setAttribute('role', 'tree');
  }

  findTreeitems(this.domNode, this, false);

  this.updateVisibleTreeitems();

  this.firstTreeitem.domNode.tabIndex = 0;

};

Tree.prototype.setFocusToItem = function (treeitem) {

  for (var i = 0; i < this.treeitems.length; i++) {
    var ti = this.treeitems[i];

    if (ti === treeitem) {
      ti.domNode.tabIndex = 0;
      ti.domNode.focus();
    }
    else {
      ti.domNode.tabIndex = -1;
    }
  }

};

Tree.prototype.setFocusToNextItem = function (currentItem) {

  var nextItem = false;

  for (var i = (this.treeitems.length - 1); i >= 0; i--) {
    var ti = this.treeitems[i];
    if (ti === currentItem) {
      break;
    }
    if (ti.isVisible) {
      nextItem = ti;
    }
  }

  if (nextItem) {
    this.setFocusToItem(nextItem);
  }

};

Tree.prototype.setFocusToPreviousItem = function (currentItem) {

  var prevItem = false;

  for (var i = 0; i < this.treeitems.length; i++) {
    var ti = this.treeitems[i];
    if (ti === currentItem) {
      break;
    }
    if (ti.isVisible) {
      prevItem = ti;
    }
  }

  if (prevItem) {
    this.setFocusToItem(prevItem);
  }
};

Tree.prototype.setFocusToParentItem = function (currentItem) {

  if (currentItem.groupTreeitem) {
    this.setFocusToItem(currentItem.groupTreeitem);
  }
};

Tree.prototype.setFocusToFirstItem = function () {
  this.setFocusToItem(this.firstTreeitem);
};

Tree.prototype.setFocusToLastItem = function () {
  this.setFocusToItem(this.lastTreeitem);
};

Tree.prototype.expandTreeitem = function (currentItem) {

  if (currentItem.isExpandable) {
    currentItem.domNode.setAttribute('aria-expanded', true);
    this.updateVisibleTreeitems();
  }

};

Tree.prototype.expandAllSiblingItems = function (currentItem) {
  for (var i = 0; i < this.treeitems.length; i++) {
    var ti = this.treeitems[i];

    if ((ti.groupTreeitem === currentItem.groupTreeitem) && ti.isExpandable) {
      this.expandTreeitem(ti);
    }
  }

};

Tree.prototype.collapseTreeitem = function (currentItem) {

  var groupTreeitem = false;

  if (currentItem.isExpanded()) {
    groupTreeitem = currentItem;
  }
  else {
    groupTreeitem = currentItem.groupTreeitem;
  }

  if (groupTreeitem) {
    groupTreeitem.domNode.setAttribute('aria-expanded', false);
    this.updateVisibleTreeitems();
    this.setFocusToItem(groupTreeitem);
  }

};

Tree.prototype.updateVisibleTreeitems = function () {

  this.firstTreeitem = this.treeitems[0];

  for (var i = 0; i < this.treeitems.length; i++) {
    var ti = this.treeitems[i];

    var parent = ti.domNode.parentNode;

    ti.isVisible = true;

    while (parent && (parent !== this.domNode)) 
    {

      if (parent.getAttribute('aria-expanded') == 'false') {
        ti.isVisible = false;
      }
      parent = parent.parentNode;
    }

    if (ti.isVisible) {
      this.lastTreeitem = ti;
    }
  }

};

Tree.prototype.setFocusByFirstCharacter = function (currentItem, char) {
  var start, index, char = char.toLowerCase();

  // Get start index for search based on position of currentItem
  start = this.treeitems.indexOf(currentItem) + 1;
  if (start === this.treeitems.length) {
    start = 0;
  }

  // Check remaining slots in the menu
  index = this.getIndexFirstChars(start, char);

  // If not found in remaining slots, check from beginning
  if (index === -1) {
    index = this.getIndexFirstChars(0, char);
  }

  // If match was found...
  if (index > -1) {
    this.setFocusToItem(this.treeitems[index]);
  }
};

Tree.prototype.getIndexFirstChars = function (startIndex, char) {
  for (var i = startIndex; i < this.firstChars.length; i++) {
    if (this.treeitems[i].isVisible) {
      if (char === this.firstChars[i]) {
        return i;
      }
    }
  }
  return -1;
};

</script>
</head>
<body>
		<h3 id="tree_label">
  Task Viewer
</h3>
<ul role="tree" aria-labelledby="tree_label">
  <li role="treeitem" aria-expanded="false">
    <span>
      Tasks
    </span>
    <ul role="group">
    <table border="2" class="w3-table-all w3-hoverable">
       <tr>
        <th>No</th>
        <th>File ID</th>
        <th>FileName</th>
        <th>To</th>
        <th>Status</th>
        <th>Date</th>
   </tr>
    <%
    try
    {
        String query="select tfname,tfid,toemp,tfcreated,tfstatus from taskfile where toemp is not null";
        Connection conn=DBConnect.getLocalDBConnection();
        Statement stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery(query);
        while(rs.next())
        {
        	//loc=1;
        	String filename=rs.getString(1);
    %>
    
   <tr>	
           		<td><%out.print(""+loc); %></td>
           		<td><%out.print(rs.getString("tfid")); %></a></td>
           		<td><a href ="DownloadClob?filename=<%=filename%>"><%out.print(rs.getString(1)); %></a> </td>
           		<td><%out.print(rs.getString(3)); %> </td>
           		<td><%out.print(rs.getString(5)); %> </td>
           		<td><%out.print(rs.getTimestamp(4)); %> </td>
           		
           		<%-- <td><%out.print(rs.getString("cfmail"));; %></td> --%>
           </tr>
          
      </li>
      <%
      	loc++;
       }
   %>
   
   <%
   }
   catch(Exception e)
   {
        e.printStackTrace();
   }
   %>
     <%
    try
    {
        String query="select asn_fname,tfid,touser,tfcreated,status from taskfile,assigntask where assigntask.asn_fname=taskfile.tfname order by tfcreated desc";
        Connection conn=DBConnect.getLocalDBConnection();
        Statement stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery(query);
        while(rs.next())
        {
        	//loc=1;
        	String filename=rs.getString(1);
    %>
    
   <tr>	
           		<td><%out.print(""+loc); %></td>
           		<td><%out.print(rs.getString("tfid")); %></a></td>
           		<td><a href ="DownloadClob?filename=<%=filename%>"><%out.print(rs.getString("asn_fname")); %></a> </td>
           		<td><%out.print(rs.getString(3)); %> </td>
           		<td><%out.print(rs.getString(5)); %> </td>
           		<td><%out.print(rs.getTimestamp(4)); %> </td>
           		
           		<%-- <td><%out.print(rs.getString("cfmail"));; %></td> --%>
           </tr>
          
      </li>
      <%
      	loc++;
       }
   %>
   
   <%
   }
   catch(Exception e)
   {
        e.printStackTrace();
   }
   %>
   </table>
  
      <li role="treeitem" class="doc">
        Msg 2
      </li>
      <li role="treeitem" aria-expanded="false">
        <span>
          Msg 3
        </span>
        <ul role="group">
          <li role="treeitem" class="doc">
            
          </li>
          <li role="treeitem" class="doc">
            project-3B.docx
          </li>
          <li role="treeitem" class="doc">
            project-3C.docx
          </li>
        </ul>
      </li>
      <li role="treeitem" class="doc">
        project-4.docx
      </li>
      <li role="treeitem" aria-expanded="false">
        <span>
          Project 5
        </span>
        <ul role="group">
          <li role="treeitem" class="doc">
            project-5A.docx
          </li>
          <li role="treeitem" class="doc">
            project-5B.docx
          </li>
          <li role="treeitem" class="doc">
            project-5C.docx
          </li>
          
        </ul>
      </li>
    </ul>
  </li>
  <li role="treeitem" aria-expanded="false">
    <span>
      Reports
    </span>
    <ul role="group">
      <li role="treeitem" aria-expanded="false">
        <span>
         	Reports
        </span>
        <ul role="group">
          <li role="treeitem" class="doc">
          	<table border="2" class="w3-table-all w3-hoverable">
       <tr>
        <th>No</th>
        <th>From</th>
        <th>Request</th>
        <th>Mail</th>
        <th>Reply</th>
        
   </tr>
    <%
    try
    {
        String query="select cfname_ref,cftext,cfmail from contactus";
        Connection conn=DBConnect.getLocalDBConnection();
        Statement stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery(query);
        while(rs.next())
        {
        	//loc=1;
        	String filename=rs.getString(1);
    %>
    
   <tr>	
           		<td><%out.print(""+loc1); %></td>
           		<td><%out.print(rs.getString(1)); %></td>
           		<td><%out.print(rs.getString(2)); %> </td>
           		<td><%out.print(rs.getString(3)); %> </td>
           		<td><a href=" #">Reply</a> </td>
           		
           		<%-- <td><%out.print(rs.getString("cfmail"));; %></td> --%>
           </tr>
          
      </li>
      <%
      	loc1++;
       }
   %>
   
   <%
       
   }
   catch(Exception e)
   {
        e.printStackTrace();
   }
   %>
   </table>
          </li>
          <li role="treeitem" class="doc">
            report-1B.docx
          </li>
          <li role="treeitem" class="doc">
            report-1C.docx
          </li>
        </ul>
      </li>
      <li role="treeitem" aria-expanded="false">
        <span>
          report-2
        </span>
        <ul role="group">
          <li role="treeitem" class="doc">
            report-2A.docx
          </li>
          <li role="treeitem" class="doc">
            report-2B.docx
          </li>
          <li role="treeitem" class="doc">
            report-2C.docx
          </li>
          <li role="treeitem" class="doc">
            report-2D.docx
          </li>
        </ul>
      </li>
      <li role="treeitem" aria-expanded="false">
        <span>
          report-3
        </span>
        <ul role="group">
          <li role="treeitem" class="doc">
            report-3A.docx
          </li>
          <li role="treeitem" class="doc">
            report-3B.docx
          </li>
          <li role="treeitem" class="doc">
            report-3C.docx
          </li>
          <li role="treeitem" class="doc">
            report-3D.docx
          </li>
        </ul>
      </li>
    </ul>
  </li>
  <li role="treeitem" aria-expanded="false">
    <span>
      Letters
    </span>
    <ul role="group">
      <li role="treeitem" aria-expanded="false">
        <span>
          letter-1
        </span>
        <ul>
          <li role="treeitem" class="doc">
            letter-1A.docx
          </li>
          <li role="treeitem" class="doc">
            letter-1B.docx
          </li>
          <li role="treeitem" class="doc">
            letter-1C.docx
          </li>
        </ul>
      </li>
      <li role="treeitem" aria-expanded="false">
        <span>
          letter-2
        </span>
        <ul role="group">
          <li role="treeitem" class="doc">
            letter-2A.docx
          </li>
          <li role="treeitem" class="doc">
            letter-2B.docx
          </li>
          <li role="treeitem" class="doc">
            letter-2C.docx
          </li>
          <li role="treeitem" class="doc">
            letter-2D.docx
          </li>
        </ul>
      </li>
      <li role="treeitem" aria-expanded="false">
        <span>
          letter-3
        </span>
        <ul role="group">
          <li role="treeitem" class="doc">
            letter-3A.docx
          </li>
          <li role="treeitem" class="doc">
            letter-3B.docx
          </li>
          <li role="treeitem" class="doc">
            letter-3C.docx
          </li>
          <li role="treeitem" class="doc">
            letter-3D.docx
          </li>
        </ul>
      </li>
    </ul>
  </li>
</ul>
<p>
  <%
  	if(loc>0)
  	{
  		loc=1;
  		loc1=1;
  	}
  %>
</p>
</body>
</html>