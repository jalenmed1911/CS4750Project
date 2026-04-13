<?php
session_start();
require("transferportaldb.php");

// Simple login logic
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['username']) && isset($_POST['password'])) {
    // In a real app, you would validate credentials against the DB here
    if (validLogin($_POST['username'], $_POST['password'])) {
        $_SESSION['user'] = $_POST['username'];
        $_SESSION['userID'] = getUserID($_POST['username']);
        header("Location: dashboard.php");
        exit();
    } else {
        $_SESSION['error'] = "Invalid username or password.";
    }
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' &&isset($_POST['Create'])) {
    header("Location: createAccount.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['CreateAccount'])) {
    if (validateUsername($_POST['username']) && !isset($_POST['Return'])) {
        createUser($_POST['username'], $_POST['password']);
        $_SESSION['success'] = "Account created successfully. Please log in.";
        header("Location: login.php");
    } else {
        $_SESSION['error'] = "Username already exists.";
        header("Location: createAccount.php");
    }
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['Delete'])) {
    deleteUser($_SESSION['user']);
    session_destroy();
    header("Location: index.php");
    exit();
}

// Logout logic
if (isset($_GET['logout'])) {
    session_destroy();
    header("Location: index.php");
    exit();
}

// Redirect if already logged in
if (isset($_SESSION['user'])) {
    header("Location: dashboard.php");
    exit();
}

if (!isset($_SESSION['user'])) {
    header("Location: login.php");
    exit();
}
?>

<?php if (isset($error)) { echo '<p class="error">' . htmlspecialchars($error) . '</p>'; } ?>
