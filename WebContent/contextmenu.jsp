<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
           
            var menuDisplayed = false;
            var menuBox = null;
           
            window.addEventListener("contextmenu", function() {
                var left = arguments[0].clientX;
                var top = arguments[0].clientY;
               
                menuBox = window.document.querySelector(".menu");
                menuBox.style.left = left + "px";
                menuBox.style.top = top + "px";
                menuBox.style.display = "block";
               
                arguments[0].preventDefault();
               
                menuDisplayed = true;
            }, false);
           
            window.addEventListener("click", function() {
                if(menuDisplayed == true){
                    menuBox.style.display = "none";
                }
            }, true);
        </script>
        <style>
            .menu
            {
                width: 150px;
                box-shadow: 3px 3px 5px #888888;
                border-style: solid;
                border-width: 1px;
                border-color: grey;
                border-radius: 2px;
                padding-left: 5px;
                padding-right: 5px;
                padding-top: 3px;
                padding-bottom: 3px;
                position: fixed;
                display: none;
            }
           
            .menu-item
            {
                height: 20px;
            }
           
            .menu-item:hover
            {
                background-color: #6CB5FF;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="menu">
            <div class="menu-item"><a href="createtask.jsp">CreateTask</div>
            <div class="menu-item"><a href="taskassign.jsp">AssignTask</div>
            <hr>
            <div class="menu-item"><a href="index.html">OpemIndex</a></div>
            <div class="menu-item"><a href="index.html">Search On Bing</div>
            <hr>
            <div class="menu-item"><a href="logout.jsp">Logout</div>
        </div>
    </body>
</html>