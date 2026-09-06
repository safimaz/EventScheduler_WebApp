<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>EventSync | Event & Resource Scheduler</title>

    <style>

        /* ==============================
           GLOBAL STYLES
        ============================== */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f8fafc;
            color: #1e293b;
            line-height: 1.6;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: auto;
        }


        /* ==============================
           NAVBAR
        ============================== */

        .navbar {
            height: 72px;
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;

            display: flex;
            align-items: center;
            justify-content: space-between;

            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-container {
            width: 90%;
            max-width: 1200px;
            margin: auto;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;

            font-size: 22px;
            font-weight: 700;
            color: #0f172a;
        }

        .logo-icon {
            width: 38px;
            height: 38px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 9px;

            background: #2563eb;
            color: white;

            font-size: 19px;
            font-weight: bold;
        }

        .logo span {
            color: #2563eb;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 32px;

            list-style: none;
        }

        .nav-links a {
            color: #475569;
            font-size: 14px;
            font-weight: 500;

            transition: 0.2s;
        }

        .nav-links a:hover {
            color: #2563eb;
        }

        .nav-login {
            padding: 10px 22px;

            background: #2563eb;
            color: white !important;

            border-radius: 7px;

            font-weight: 600 !important;
        }

        .nav-login:hover {
            background: #1d4ed8;
        }


        /* ==============================
           HERO SECTION
        ============================== */

        .hero {
            min-height: 600px;

            display: flex;
            align-items: center;

            background:
                radial-gradient(circle at 80% 30%,
                rgba(37, 99, 235, 0.10),
                transparent 35%),
                #f8fafc;
        }

        .hero-content {
            max-width: 680px;
        }

        .badge {
            display: inline-block;

            padding: 7px 14px;
            margin-bottom: 22px;

            border-radius: 30px;

            background: #eff6ff;
            color: #2563eb;

            font-size: 13px;
            font-weight: 600;
        }

        .hero h1 {
            font-size: 52px;
            line-height: 1.12;

            letter-spacing: -1.5px;

            color: #0f172a;

            margin-bottom: 22px;
        }

        .hero h1 span {
            color: #2563eb;
        }

        .hero-description {
            max-width: 600px;

            font-size: 17px;
            color: #64748b;

            margin-bottom: 32px;
        }

        .hero-buttons {
            display: flex;
            gap: 14px;
        }

        .primary-btn {
            padding: 13px 26px;

            background: #2563eb;
            color: white;

            border-radius: 7px;

            font-size: 15px;
            font-weight: 600;

            transition: 0.2s;
        }

        .primary-btn:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }

        .secondary-btn {
            padding: 13px 26px;

            background: white;
            color: #334155;

            border: 1px solid #cbd5e1;

            border-radius: 7px;

            font-size: 15px;
            font-weight: 600;
        }

        .secondary-btn:hover {
            border-color: #2563eb;
            color: #2563eb;
        }


        /* ==============================
           HERO DASHBOARD
        ============================== */

        .hero-layout {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 60px;
        }

        .dashboard-preview {
            width: 450px;

            background: white;

            border: 1px solid #e2e8f0;

            border-radius: 14px;

            padding: 20px;

            box-shadow:
                0 20px 50px rgba(15, 23, 42, 0.10);
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;

            padding-bottom: 15px;
            border-bottom: 1px solid #e2e8f0;

            margin-bottom: 15px;
        }

        .dashboard-title {
            font-weight: 700;
            color: #0f172a;
        }

        .status {
            font-size: 11px;
            padding: 5px 9px;

            background: #ecfdf5;
            color: #059669;

            border-radius: 20px;
            font-weight: 600;
        }

        .event-card {
            display: flex;
            align-items: center;
            gap: 14px;

            padding: 13px;

            margin-bottom: 10px;

            background: #f8fafc;

            border: 1px solid #e2e8f0;

            border-radius: 8px;
        }

        .event-date {
            width: 45px;
            height: 45px;

            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;

            background: #eff6ff;

            color: #2563eb;

            border-radius: 7px;

            font-weight: 700;
        }

        .event-date small {
            font-size: 9px;
        }

        .event-info h4 {
            font-size: 13px;
            color: #0f172a;
        }

        .event-info p {
            font-size: 11px;
            color: #64748b;
        }


        /* ==============================
           FEATURES
        ============================== */

        .features {
            padding: 90px 0;

            background: white;
        }

        .section-header {
            text-align: center;

            max-width: 650px;
            margin: 0 auto 50px;
        }

        .section-header h2 {
            font-size: 32px;

            color: #0f172a;

            margin-bottom: 12px;
        }

        .section-header p {
            color: #64748b;
        }

        .feature-grid {
            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 24px;
        }

        .feature-card {
            padding: 28px;

            border: 1px solid #e2e8f0;

            border-radius: 10px;

            background: white;

            transition: 0.25s;
        }

        .feature-card:hover {
            transform: translateY(-4px);

            box-shadow:
                0 12px 30px rgba(15, 23, 42, 0.08);

            border-color: #bfdbfe;
        }

        .feature-icon {
            width: 46px;
            height: 46px;

            display: flex;
            align-items: center;
            justify-content: center;

            margin-bottom: 18px;

            border-radius: 9px;

            background: #eff6ff;
            color: #2563eb;

            font-size: 20px;
        }

        .feature-card h3 {
            font-size: 17px;
            margin-bottom: 8px;

            color: #0f172a;
        }

        .feature-card p {
            font-size: 14px;
            color: #64748b;
        }


        /* ==============================
           CTA
        ============================== */

        .cta {
            padding: 80px 0;
            background: #0f172a;
        }

        .cta-content {
            text-align: center;
            max-width: 700px;
            margin: auto;
        }

        .cta h2 {
            font-size: 34px;
            color: white;
            margin-bottom: 14px;
        }

        .cta p {
            color: #94a3b8;
            margin-bottom: 28px;
        }


        /* ==============================
           FOOTER
        ============================== */

        .footer {
            background: #020617;
            color: #94a3b8;

            padding: 35px 0;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .footer-logo {
            color: white;
            font-weight: 700;
            font-size: 17px;
        }

        .footer-text {
            font-size: 13px;
        }


        /* ==============================
           RESPONSIVE DESIGN
        ============================== */

        @media (max-width: 900px) {

            .hero-layout {
                flex-direction: column;
                text-align: center;

                padding: 70px 0;
            }

            .hero-content {
                max-width: 700px;
            }

            .hero-description {
                margin-left: auto;
                margin-right: auto;
            }

            .hero-buttons {
                justify-content: center;
            }

            .dashboard-preview {
                width: 100%;
                max-width: 450px;
            }

            .feature-grid {
                grid-template-columns: 1fr;
            }

            .nav-links {
                display: none;
            }
        }

        @media (max-width: 600px) {

            .hero h1 {
                font-size: 38px;
            }

            .hero-buttons {
                flex-direction: column;
            }

            .primary-btn,
            .secondary-btn {
                text-align: center;
            }

            .footer-content {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }
        }

    </style>

</head>


<body>


    <!-- ==============================
         NAVIGATION BAR
    ============================== -->

    <header class="navbar">

        <div class="nav-container">

            <a href="index.jsp" class="logo">

                <div class="logo-icon">
                    ES
                </div>

                Event<span>Sync</span>

            </a>


            <ul class="nav-links">

                <li>
                    <a href="#features">Features</a>
                </li>

                <li>
                    <a href="#about">About</a>
                </li>

                <li>
                    <a href="#contact">Contact</a>
                </li>

                <li>
                    <a href="login.jsp" class="nav-login">
                        Login
                    </a>
                </li>

            </ul>

        </div>

    </header>



    <!-- ==============================
         HERO SECTION
    ============================== -->

    <main>

        <section class="hero">

            <div class="container hero-layout">


                <div class="hero-content">

                    <div class="badge">
                        Enterprise Event Management Platform
                    </div>


                    <h1>
                        Plan. Book. Manage.
                        <span>Effortlessly.</span>
                    </h1>


                    <p class="hero-description">

                        EventSync is an integrated event booking and
                        resource scheduling platform designed to simplify
                        room reservations, resource allocation, event
                        management and organizational planning.

                    </p>


                    <div class="hero-buttons">

                        <!-- LOGIN BUTTON -->

                        <a href="login.jsp" class="primary-btn">
                            Login to Portal →
                        </a>


                        <a href="#features" class="secondary-btn">
                            Explore Features
                        </a>

                    </div>

                </div>



                <!-- Dashboard Preview -->

                <div class="dashboard-preview">

                    <div class="dashboard-header">

                        <div class="dashboard-title">
                            Upcoming Events
                        </div>

                        <div class="status">
                            System Online
                        </div>

                    </div>


                    <div class="event-card">

                        <div class="event-date">
                            <small>SEP</small>
                            08
                        </div>

                        <div class="event-info">

                            <h4>
                                Technology Workshop
                            </h4>

                            <p>
                                Conference Room A · 10:00 AM
                            </p>

                        </div>

                    </div>


                    <div class="event-card">

                        <div class="event-date">
                            <small>SEP</small>
                            10
                        </div>

                        <div class="event-info">

                            <h4>
                                Team Strategy Meeting
                            </h4>

                            <p>
                                Meeting Room 204 · 02:00 PM
                            </p>

                        </div>

                    </div>


                    <div class="event-card">

                        <div class="event-date">
                            <small>SEP</small>
                            12
                        </div>

                        <div class="event-info">

                            <h4>
                                Product Presentation
                            </h4>

                            <p>
                                Auditorium · 11:30 AM
                            </p>

                        </div>

                    </div>

                </div>

            </div>

        </section>



        <!-- ==============================
             FEATURES
        ============================== -->

        <section class="features" id="features">

            <div class="container">

                <div class="section-header">

                    <h2>
                        Everything You Need to Manage Events
                    </h2>

                    <p>
                        A centralized platform for managing events,
                        rooms, resources and organizational schedules.
                    </p>

                </div>


                <div class="feature-grid">


                    <div class="feature-card">

                        <div class="feature-icon">
                            📅
                        </div>

                        <h3>
                            Event Booking
                        </h3>

                        <p>
                            Create and manage events with complete
                            scheduling information including date,
                            time, venue and participants.
                        </p>

                    </div>



                    <div class="feature-card">

                        <div class="feature-icon">
                            🏢
                        </div>

                        <h3>
                            Room Management
                        </h3>

                        <p>
                            Check room availability and reserve
                            suitable meeting rooms, conference
                            halls and other event spaces.
                        </p>

                    </div>



                    <div class="feature-card">

                        <div class="feature-icon">
                            ⚙
                        </div>

                        <h3>
                            Resource Scheduling
                        </h3>

                        <p>
                            Efficiently allocate projectors,
                            equipment, seating arrangements and
                            other resources required for events.
                        </p>

                    </div>



                    <div class="feature-card">

                        <div class="feature-icon">
                            🔄
                        </div>

                        <h3>
                            Conflict Detection
                        </h3>

                        <p>
                            Prevent double bookings and scheduling
                            conflicts through centralized resource
                            availability management.
                        </p>

                    </div>



                    <div class="feature-card">

                        <div class="feature-icon">
                            👥
                        </div>

                        <h3>
                            User Management
                        </h3>

                        <p>
                            Manage users, roles and access permissions
                            using a structured role-based access model.
                        </p>

                    </div>



                    <div class="feature-card">

                        <div class="feature-icon">
                            📊
                        </div>

                        <h3>
                            Reports & Insights
                        </h3>

                        <p>
                            Generate useful reports on events,
                            resource utilization, room bookings
                            and scheduling activities.
                        </p>

                    </div>


                </div>

            </div>

        </section>



        <!-- ==============================
             CTA SECTION
        ============================== -->

        <section class="cta" id="about">

            <div class="container">

                <div class="cta-content">

                    <h2>
                        Ready to streamline your event management?
                    </h2>

                    <p>
                        Access the EventSync portal and manage
                        your organization's events and resources
                        from one centralized platform.
                    </p>


                    <a href="login.jsp" class="primary-btn">
                        Access EventSync →
                    </a>

                </div>

            </div>

        </section>

    </main>



    <!-- ==============================
         FOOTER
    ============================== -->

    <footer class="footer" id="contact">

        <div class="container footer-content">

            <div class="footer-logo">
                EventSync
            </div>

            <div class="footer-text">
                © 2026 EventSync. Event & Resource Scheduling Platform.
            </div>

        </div>

    </footer>


</body>

</html>

