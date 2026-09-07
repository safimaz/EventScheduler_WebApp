<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
 
<head>
 
    <meta charset="UTF-8">
 
    <title>Add Resource - EventSync</title>
 
    <style>
 
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }
 
        .navbar {
            background-color: #1f2937;
            color: white;
            padding: 18px 40px;
            font-size: 22px;
            font-weight: bold;
        }
 
        .container {
            width: 500px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
 
        h2 {
            text-align: center;
            margin-bottom: 25px;
        }
 
        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 6px;
            font-weight: bold;
        }
 
        input,
        select {
            width: 100%;
            padding: 11px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
 
        button {
            width: 100%;
            margin-top: 25px;
            padding: 12px;
            background-color: #2563eb;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }
 
        button:hover {
            background-color: #1d4ed8;
        }
 
        .back {
            display: block;
            text-align: center;
            margin-top: 15px;
            text-decoration: none;
            color: #2563eb;
        }
 
    </style>
 
</head>
 
<body>
 
<div class="navbar">
    EventSync
</div>
 
<div class="container">
 
    <h2>Add Resource</h2>
 
    <form action="resources" method="post">
 
        <input type="hidden"
               name="action"
               value="add">
 
        <label>Resource Name</label>
 
        <input type="text"
               name="resourceName"
               required
               maxlength="100">
 
        <label>Resource Type</label>
 
        <input type="text"
               name="resourceType"
               maxlength="100">
 
        <label>Quantity</label>
 
        <input type="number"
               name="quantity"
               min="1"
               required>
 
        <label>Status</label>
 
        <select name="status" required>
 
            <option value="AVAILABLE">
                AVAILABLE
</option>
 
            <option value="MAINTENANCE">
                MAINTENANCE
</option>
 
            <option value="INACTIVE">
                INACTIVE
</option>
 
        </select>
 
        <button type="submit">
            Add Resource
</button>
 
    </form>
 
    <a href="resources" class="back">
        ← Back to Resources
</a>
 
</div>
 
</body>
 
</html>