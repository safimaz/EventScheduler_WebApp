<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login - Event Room Scheduler</title>


    <style>

        /* =========================================
           GLOBAL
        ========================================= */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {

            font-family: "Segoe UI", Arial, sans-serif;

            background: #f8fafc;

            color: #1e293b;

            min-height: 100vh;
        }

        a {
            text-decoration: none;
        }


        /* =========================================
           NAVBAR
        ========================================= */

        .navbar {

            height: 72px;

            background: #ffffff;

            border-bottom: 1px solid #e2e8f0;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 5%;
        }


        /* =========================================
           LOGO
        ========================================= */

        .logo {

            display: flex;

            align-items: center;

            gap: 10px;

            color: #0f172a;

            font-size: 22px;

            font-weight: 700;
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

            font-size: 15px;

            font-weight: 700;
        }

        .logo span {

            color: #2563eb;
        }


        /* =========================================
           BACK HOME
        ========================================= */

        .back-home {

            color: #475569;

            font-size: 14px;

            font-weight: 500;

            transition: 0.2s;
        }

        .back-home:hover {

            color: #2563eb;
        }


        /* =========================================
           LOGIN PAGE
        ========================================= */

        .login-section {

            min-height: calc(100vh - 72px);

            display: flex;

            justify-content: center;

            align-items: center;

            padding: 45px 20px;

            background:

                radial-gradient(
                    circle at 15% 20%,
                    rgba(37, 99, 235, 0.08),
                    transparent 30%
                ),

                radial-gradient(
                    circle at 85% 80%,
                    rgba(37, 99, 235, 0.06),
                    transparent 30%
                ),

                #f8fafc;
        }


        /* =========================================
           LOGIN CONTAINER
        ========================================= */

        .login-container {

            width: 100%;

            max-width: 430px;

            background: #ffffff;

            border: 1px solid #e2e8f0;

            border-radius: 12px;

            padding: 40px;

            box-shadow:
                0 20px 50px rgba(15, 23, 42, 0.08);
        }


        /* =========================================
           LOGIN HEADER
        ========================================= */

        .login-header {

            text-align: center;

            margin-bottom: 30px;
        }

        .login-icon {

            width: 52px;

            height: 52px;

            margin: 0 auto 18px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 10px;

            background: #eff6ff;

            color: #2563eb;

            font-size: 23px;
        }

        .login-header h1 {

            color: #0f172a;

            font-size: 27px;

            font-weight: 700;

            margin-bottom: 7px;
        }

        .login-header p {

            color: #64748b;

            font-size: 14px;
        }


        /* =========================================
           ERROR MESSAGE
        ========================================= */

        .error {

            display: flex;

            align-items: center;

            gap: 10px;

            background: #fef2f2;

            color: #dc2626;

            border: 1px solid #fecaca;

            padding: 12px 14px;

            margin-bottom: 20px;

            border-radius: 7px;

            font-size: 13px;

            line-height: 1.4;
        }

        .error-icon {

            width: 22px;

            height: 22px;

            flex-shrink: 0;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 50%;

            background: #fee2e2;

            font-size: 12px;

            font-weight: bold;
        }


        /* =========================================
           FORM
        ========================================= */

        .form-group {

            margin-bottom: 20px;
        }

        label {

            display: block;

            margin-bottom: 7px;

            color: #334155;

            font-size: 13px;

            font-weight: 600;
        }


        /* =========================================
           INPUT WRAPPER
        ========================================= */

        .input-wrapper {

            position: relative;
        }


        /* =========================================
           INPUT ICON
        ========================================= */

        .input-icon {

            position: absolute;

            left: 14px;

            top: 50%;

            transform: translateY(-50%);

            color: #94a3b8;

            font-size: 14px;

            pointer-events: none;
        }


        /* =========================================
           INPUTS
        ========================================= */

        input[type="email"],
        input[type="password"] {

            width: 100%;

            height: 46px;

            padding: 0 14px 0 41px;

            border: 1px solid #cbd5e1;

            border-radius: 7px;

            outline: none;

            background: #ffffff;

            color: #1e293b;

            font-family: inherit;

            font-size: 14px;

            transition: all 0.2s ease;
        }

        input[type="email"]::placeholder,
        input[type="password"]::placeholder {

            color: #94a3b8;
        }

        input[type="email"]:focus,
        input[type="password"]:focus {

            border-color: #2563eb;

            box-shadow:
                0 0 0 3px rgba(37, 99, 235, 0.10);
        }


        /* =========================================
           LOGIN BUTTON
        ========================================= */

        button {

            width: 100%;

            height: 46px;

            margin-top: 6px;

            border: none;

            border-radius: 7px;

            background: #2563eb;

            color: #ffffff;

            cursor: pointer;

            font-family: inherit;

            font-size: 15px;

            font-weight: 600;

            transition: all 0.2s ease;
        }

        button:hover {

            background: #1d4ed8;

            transform: translateY(-1px);

            box-shadow:
                0 6px 15px rgba(37, 99, 235, 0.20);
        }

        button:active {

            transform: translateY(0);
        }


        /* =========================================
           DIVIDER
        ========================================= */

        .divider {

            display: flex;

            align-items: center;

            gap: 12px;

            margin: 27px 0 20px;

            color: #94a3b8;

            font-size: 10px;

            font-weight: 600;

            letter-spacing: 0.8px;
        }

        .divider::before,
        .divider::after {

            content: "";

            height: 1px;

            flex: 1;

            background: #e2e8f0;
        }


        /* =========================================
           SECURITY INFORMATION
        ========================================= */

        .security-box {

            display: flex;

            align-items: flex-start;

            gap: 10px;

            padding: 13px;

            background: #f8fafc;

            border: 1px solid #e2e8f0;

            border-radius: 7px;
        }

        .security-icon {

            color: #2563eb;

            font-size: 15px;

            margin-top: 1px;
        }

        .security-box p {

            color: #64748b;

            font-size: 11px;

            line-height: 1.5;
        }


        /* =========================================
           LOGIN FOOTER
        ========================================= */

        .login-footer {

            text-align: center;

            margin-top: 24px;

            color: #94a3b8;

            font-size: 11px;
        }


        /* =========================================
           RESPONSIVE
        ========================================= */

        @media (max-width: 600px) {

            .navbar {

                height: 64px;

                padding: 0 20px;
            }

            .login-section {

                min-height: calc(100vh - 64px);

                padding: 30px 16px;
            }

            .login-container {

                padding: 30px 24px;
            }

            .logo {

                font-size: 19px;
            }

            .logo-icon {

                width: 34px;

                height: 34px;
            }

            .back-home {

                font-size: 13px;
            }

            .login-header h1 {

                font-size: 24px;
            }
        }

    </style>

</head>


<body>


    <!-- =========================================
         NAVIGATION BAR
    ========================================== -->

    <header class="navbar">


        <!-- EVENTSYNC LOGO -->

        <a href="index.jsp" class="logo">

            <div class="logo-icon">
                ES
            </div>

            Event<span>Sync</span>

        </a>


        <!-- BACK TO HOME -->

        <a href="index.jsp" class="back-home">

            ← Back to Home

        </a>


    </header>



    <!-- =========================================
         LOGIN SECTION
    ========================================== -->

    <main class="login-section">


        <div class="login-container">


            <!-- =====================================
                 LOGIN HEADER
            ====================================== -->

            <div class="login-header">

                <div class="login-icon">
                    🔐
                </div>

                <h1>
                    Welcome Back
                </h1>

                <p>
                    Login to your EventSync account
                </p>

            </div>



            <!-- =====================================
                 ERROR MESSAGE
                 LOGIC UNCHANGED
            ====================================== -->

            <% 
                String errorMessage =
                    (String) request.getAttribute("errorMessage");

                if (errorMessage != null) {
            %>

                <div class="error">

                    <div class="error-icon">
                        !
                    </div>

                    <div>
                        <%= errorMessage %>
                    </div>

                </div>

            <%
                }
            %>



            <!-- =====================================
                 LOGIN FORM
                 LOGIC UNCHANGED
            ====================================== -->

            <form action="login" method="post">


                <!-- EMAIL -->

                <div class="form-group">

                    <label for="email">
                        Email Address
                    </label>

                    <div class="input-wrapper">

                        <span class="input-icon">
                            ✉
                        </span>

                        <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="Enter your email"
                            
                        >

                    </div>

                </div>



                <!-- PASSWORD -->

                <div class="form-group">

                    <label for="password">
                        Password
                    </label>

                    <div class="input-wrapper">

                        <span class="input-icon">
                            🔒
                        </span>

                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Enter your password"
                            
                        >

                    </div>

                </div>



                <!-- LOGIN -->

                <button type="submit">

                    Login →

                </button>


            </form>



            <!-- =====================================
                 SECURITY DIVIDER
            ====================================== -->

            <div class="divider">

                SECURE ACCESS

            </div>



            <!-- =====================================
                 SECURITY INFORMATION
            ====================================== -->

            <div class="security-box">

                <div class="security-icon">
                    🛡
                </div>

                <p>

                    Your account is protected by secure
                    authentication. Access to EventSync
                    features is based on your assigned
                    user role.

                </p>

            </div>



            <!-- =====================================
                 FOOTER
            ====================================== -->

            <div class="login-footer">

                © 2026 EventSync · Event & Resource
                Scheduling Platform

            </div>


        </div>

    </main>


</body>

</html>
