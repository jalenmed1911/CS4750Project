<?php
require("transferportaldb.php");
session_start();

if (!isset($_SESSION['user'])) {
    header("Location: index.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Offers - Transfer Portal</title>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
    <nav class="top-nav">
        <div class="brand">Fantasy Football Portal</div>
        <div class="user-menu">
            <span>Welcome, <a href="profile.php" style="text-decoration: none; color: inherit;"><strong><?php echo htmlspecialchars($_SESSION['user']); ?></strong></a></span>
            <a href="index.php?logout=1" class="logout-link">Logout</a>
        </div>
    </nav>
    
    <div class="dashboard-wrapper">
        <aside class="sidebar">
            <ul class="nav-links">
                <?php
                if ($_SESSION['role'] == 'admin') {
                    echo "<li><a href='dashboard.php' class='active'>Dashboard</a></li>";
                } else {
                    echo "<li><a href='playerManagement.php'>Dashboard</a></li>";
                }
                ?>
                <li><a href="teamSearch.php">Team Search</a></li>
                <li><a href="manageOffers.php" class="active">Manage Offers</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <div class="welcome-header">
                <h1>Offers Dashboard</h1>
                <p>Manage your offers from here.</p>
            </div>
            
            <?php if (isset($_SESSION['error'])): ?>
                <div style="background: #fee2e2; color: #991b1b; padding: 1rem; border-radius: 6px; margin-bottom: 1.5rem; border: 1px solid #fecaca;">
                    <?php echo htmlspecialchars($_SESSION['error']); unset($_SESSION['error']); ?>
                </div>
            <?php endif; ?>

            <?php if (isset($_SESSION['success'])): ?>
                <div style="background: #ecfdf5; color: #065f46; padding: 1rem; border-radius: 6px; margin-bottom: 1.5rem; border: 1px solid #a7f3d0;">
                    <?php echo htmlspecialchars($_SESSION['success']); unset($_SESSION['success']); ?>
                </div>
            <?php endif; ?>

            <div class="stats-container">
                <?php
                $userID = $_SESSION['userID'];
                $playerID = getUserPlayers($userID)['playerID'];
                ?>
                <?php echo "<div class='stat-card'><h3>Total Offers</h3><div class='value'>" . count(getOffersByPlayer($playerID)) . "</div></div>"; ?>
                <?php echo "<div class='stat-card'><h3>Pending Offers</h3><div class='value'>" . count(getOffersByPlayer($playerID, 'Pending')) . "</div></div>"; ?>
                <?php echo "<div class='stat-card'><h3>Accepted Offers</h3><div class='value'>" . count(getOffersByPlayer($playerID, 'Accepted')) . "</div></div>"; ?>
                <?php echo "<div class='stat-card'><h3>Rejected Offers</h3><div class='value'>" . count(getOffersByPlayer($playerID, 'Rejected')) . "</div></div>"; ?>
            </div>
            
            <section class="activity-section">
                <h2>Manage Offers</h2>
                <?php  
                $offers = getOffersByPlayer($playerID);
                foreach($offers as $offer) {
                    $team = getTeamByID(getOfferTeamByCoach($offer['coachID'])['teamID']);
                    echo "<div class='offer-card'>";
                    echo "<h3>" . "Team: " . htmlspecialchars($team['name']) . "</h3>";
                    echo "<p><strong>Status:</strong> " . htmlspecialchars($offer['status']) . "</p>";
                    echo "<p><strong>Offer Amount:</strong> $" . number_format($offer['amount'] * 100, 0, '.', ',') . "</p>";
                    if ($offer['status'] === 'Pending' && !hasTeam($playerID)) {
                    echo "<form method='post' action='index.php'>";
                    echo "<input type='hidden' name='coachID' value='" . $offer['coachID'] . "'>";
                    echo "<input type='hidden' name='offerID' value='" . $offer['offerID'] . "'>";
                    echo "<button type='submit' name='AcceptOffer' style='margin-top: 20px; background-color: #37e11d; color: white; border: none; padding: 0.6rem 1.2rem; border-radius: 4px; cursor: pointer; font-weight: 600;'>Accept Offer</button> </form>";
                    echo "<form method='post' action='index.php'>";
                    echo "<input type='hidden' name='coachID' value='" . $offer['coachID'] . "'>";
                    echo "<input type='hidden' name='offerID' value='" . $offer['offerID'] . "'>";
                    echo "<button type='submit' name='RejectOffer' style='margin-top: 20px; background-color: #e11d48; color: white; border: none; padding: 0.6rem 1.2rem; border-radius: 4px; cursor: pointer; font-weight: 600;'>Reject Offer</button> </form>";
                    }
                    echo "</div>";
                    echo "<hr>";
                }
                ?>
            </section>
        </main>
    </div>
</body>
</html>