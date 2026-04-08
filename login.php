<?php
session_start();
require("transferportaldb.php");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Transfer Portal</title>
    <link rel="stylesheet" href="login.css">
</head>
<body>
    <div class="login-container">
        <h2>Transfer Portal Login</h2>
        <form method="post" action="index.php">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit">Sign In</button>
        </form>
        <form method="post" action="index.php">
        <button name="Create" style="margin-top: 10px;">Create Account</button>
        </form>
        <?php 
        if (isset($_SESSION['error']) && !isset($_SESSION['success'])) { 
            echo '<p class="error" style="color: red;">' . htmlspecialchars($_SESSION['error']) . '</p>'; 
            unset($_SESSION['error']);
        } 
        if (isset($_SESSION['success'])) { 
            echo '<p class="success" style="color: green;">' . htmlspecialchars($_SESSION['success']) . '</p>'; 
            unset($_SESSION['success']);
        }
        ?>
    </div>
</body>
</html>
