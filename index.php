<?php
session_start();
require("transferportaldb.php");


if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['username']) && isset($_POST['password'])) {
    if (validLogin($_POST['username'], $_POST['password'])) {
        $_SESSION['user'] = $_POST['username'];
        $_SESSION['userID'] = getUserID($_POST['username']);

        // DEFAULT role
        $_SESSION['role'] = 'user';

        // HARD-CODED ADMIN ACCOUNTS
        if (isAdmin($_SESSION['user'])) {
            $_SESSION['role'] = 'admin';
        }

        if ($_SESSION['role'] === 'admin') {
            header("Location: dashboard.php");
        } else if (hasPlayer($_SESSION['userID'])){
            header("Location: playerManagement.php");
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
    if ($_SESSION['role'] === 'admin') {
        header("Location: dashboard.php");
    } else {
        header("Location: playerManagement.php");
    }
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['Go_To_Create_Account'])) {
    header("Location: createAccount.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['Account_Creation'])) {
    if (validateUsername($_POST['Create_Account_Username']) && !isset($_POST['Return_To_Login'])) {
        createUser($_POST['Create_Account_Username'], $_POST['Create_Account_Password']);
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
    acceptOffer($_POST['offerID']);
    $_SESSION['success'] = "Offer accepted! You are now part of the team.";
    header("Location: manageOffers.php");
    exit(); 
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['RejectOffer'])) {
    $playerID = getUserPlayers($_SESSION['userID'])['playerID'];
    rejectOffer($_POST['offerID']);
    $_SESSION['success'] = "Offer rejected.";
    header("Location: manageOffers.php");
    exit();
}


if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['deleteUser'])) {
    deleteUser(getUserByID($_POST['userID'])['username']);
    $_SESSION['success'] = "User account successfully deleted.";
    header("Location: dashboard.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['removeAdmin'])) {
    removeAdmin(getUserByID($_POST['userID'])['username']);
    $_SESSION['success'] = "Admin privileges removed.";
    header("Location: dashboard.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['makeAdmin'])) {
    addAdmin(getUserByID($_POST['userID'])['username']);
    $_SESSION['success'] = "User promoted to Admin.";
    header("Location: dashboard.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['JoinRequest'])) {
    $playerID = getUserPlayers($_SESSION['userID'])['playerID'];

    if (sendJoinRequest($playerID, $_POST['teamID'])) {
        $_SESSION['success'] = "The team was impressed! You have a new pending offer.";
        header("Location: manageOffers.php");
    } else {
        $_SESSION['error'] = "The team's coaching staff has declined your request at this time.";
        header("Location: teamSearch.php");
    }
    exit();
}


if (isset($_GET['logout'])) {
    session_destroy();
    header("Location: index.php");
    exit();
}

if (isset($_SESSION['user'])) {
    if ($_SESSION['role'] === 'admin') {
        header("Location: dashboard.php");
    } else if (hasPlayer($_SESSION['userID'])) {
        header("Location: playerManagement.php");
    } else {
        header("Location: createPlayer.php");
    }
    exit();
}

if (!isset($_SESSION['user'])) {
    header("Location: login.php");
    exit();
}
?>

<?php if (isset($error)) { echo '<p class="error">' . htmlspecialchars($error) . '</p>'; } ?>
