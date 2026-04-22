<?php
session_start();
require("transferportaldb.php");





if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['username']) && isset($_POST['password'])) {
    if (validLogin($_POST['username'], $_POST['password'])) {
        $_SESSION['user'] = $_POST['username'];
        $_SESSION['userID'] = getUserID($_POST['username']);
        if (hasPlayer($_SESSION['userID'])){
        header("Location: dashboard.php");
        } else {
            header("Location: createPlayer.php");
        }
        exit();
    } else {
        $_SESSION['error'] = "Invalid username or password.";
    }
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['Playername']) && isset($_POST['Playerhometown']) && isset($_POST['position'])) {
    $positionMap = [
        'Quarterback' => 'QB',
        'Runningback' => 'RB',
        'Widereceiver' => 'WR',
        'Safety' => 'S',
        'Linebacker' => 'LB',
        'Kicker' => 'K'
    ];

    $position = $_POST['position'];
    $position = $positionMap[$position];
    $stats = [];

    if ($position == 'QB') {
        $stats = [
            'yards' => $_POST['passingYards'],
            'passing_percentage' => $_POST['passingPercentage'],
            'touchdowns' => $_POST['touchdowns'],
            'interceptions' => $_POST['interceptions']
        ];
    } elseif ($position == 'RB') {
        $stats = [
            'longest' => $_POST['longestRun'],
            'touchdowns' => $_POST['touchdowns'],
            'carries' => $_POST['carries'],
            'yards' => $_POST['yards']
        ];
    } elseif ($position == 'WR') {
        $stats = [
            'receptions' => $_POST['receptions'],
            'yards' => $_POST['yards'],
            'touchdowns' => $_POST['touchdowns'],
            'longest' => $_POST['longestReception']
        ];
    } elseif ($position == 'LB') {
        $stats = [
            'sacks' => $_POST['sacks'],
            'tackles' => $_POST['tackles'],
            'interceptions' => $_POST['interceptions'],
            'solo_tackles' => $_POST['solo_tackles']
        ];
    }
    elseif ($position == 'S') {
        $stats = [
            'solo_tackles' => $_POST['solo_tackles'],
            'total_tackles' => $_POST['total_tackles'],
            'interceptions' => $_POST['interceptions'],
            'passes_defended' => $_POST['passes_defended']
        ];
    } elseif ($position == 'K') {
        $stats = [
            'longest' => $_POST['longest'],
            'fg_attempted' => $_POST['fg_attempted'],
            'fg_made' => $_POST['fg_made'],
            'points' => $_POST['points']
        ];
    }

    createNewPlayer($_POST['Playername'], $position, $_POST['Playerhometown'], $_SESSION['userID'], $stats);
    header("Location: dashboard.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' &&isset($_POST['Create'])) {
    header("Location: createAccount.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['CreateAccount'])) {
    if (validateUsername($_POST['Cusername']) && !isset($_POST['Return'])) {
        createUser($_POST['Cusername'], $_POST['Cpassword']);
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

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['LeaveTeam'])) {
    leaveTeam($_SESSION['user']);
    header("Location: playerManagement.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['AcceptOffer'])) {
    $playerID = getUserPlayers($_SESSION['userID'])['playerID'];
    acceptOffer($playerID, $_POST['coachID']);
    header("Location: manageOffers.php");
    exit(); 
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['RejectOffer'])) {
    $playerID = getUserPlayers($_SESSION['userID'])['playerID'];
    rejectOffer($playerID, $_POST['coachID']);
    header("Location: manageOffers.php");
    exit();
}

if (isset($_GET['logout'])) {
    session_destroy();
    header("Location: index.php");
    exit();
}

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
