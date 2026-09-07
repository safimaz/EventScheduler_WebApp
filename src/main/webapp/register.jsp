<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Register - EventSync</title>

    <style>

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


        /* NAVBAR */

        .navbar {
            height: 72px;
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 5%;
        }

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

        .back-home {
            color: #475569;
            font-size: 14px;
            font-weight: 500;
        }

        .back-home:hover {
            color: #2563eb;
        }


        /* REGISTER SECTION */

        .register-section {

            min-height: calc(100vh - 72px);

            display: flex;
            justify-content: center;
            align-items: center;

            padding: 45px 20px;

            background: #f8fafc;
        }

        .register-container {

            width: 100%;
            max-width: 430px;

            background: #ffffff;

            border: 1px solid #e2e8f0;
            border-radius: 12px;

            padding: 40px;

            box-shadow:
                0 20px 50px
                rgba(15, 23, 42, 0.08);
        }


        /* HEADER */

        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .register-icon {

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

        .register-header h1 {

            color: #0f172a;

            font-size: 27px;
            font-weight: 700;

            margin-bottom: 7px;
        }

        .register-header p {

            color: #64748b;

            font-size: 14px;
        }


        /* ERROR MESSAGE */

        .error {

            background: #fef2f2;
            color: #dc2626;

            border: 1px solid #fecaca;

            padding: 12px 14px;

            margin-bottom: 20px;

            border-radius: 7px;

            font-size: 13px;
        }


        /* FORM */

        .form-group {
            margin-bottom: 18px;
        }

        label {

            display: block;

            margin-bottom: 7px;

            color: #334155;

            font-size: 13px;

            font-weight: 600;
        }

        input {

            width: 100%;

            height: 46px;

            padding: 0 14px;

            border: 1px solid #cbd5e1;

            border-radius: 7px;

            outline: none;

            font-family: inherit;

            font-size: 14px;
        }

        input:focus {

            border-color: #2563eb;

            box-shadow:
                0 0 0 3px
                rgba(37, 99, 235, 0.10);
        }


        /* BUTTON */

        button {

            width: 100%;

            height: 46px;

            margin-top: 5px;

            border: none;

            border-radius: 7px;

            background: #2563eb;

            color: #ffffff;

            cursor: pointer;

            font-family: inherit;

            font-size: 15px;

            font-weight: 600;
        }

        button:hover {
            background: #1d4ed8;
        }


        /* LOGIN LINK */

        .login-link {

            text-align: center;

            margin-top: 22px;

            color: #64748b;

            font-size: 13px;
        }

        .login-link a {

            color: #2563eb;

            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

    </style>

</head>

<body>


    <!-- NAVBAR -->

    <header class="navbar">

        <a href="index.jsp" class="logo">

            <div class="logo-icon">
                ES
            </div>

            Event<span>Sync</span>

        </a>

        <a href="index.jsp" class="back-home">
            ← Back to Home
        </a>

    </header>


    <!-- REGISTER SECTION -->

    <main class="register-section">

        <div class="register-container">


            <!-- HEADER -->

            <div class="register-header">

                <div class="register-icon">
                    👤
                </div>

                <h1>Create Account</h1>

                <p>
                    Register to start using EventSync
                </p>

            </div>


            <!-- ERROR MESSAGE -->

            <%
                String errorMessage =
                        (String) request.getAttribute("errorMessage");

                if (errorMessage != null) {
            %>

                <div class="error">
                    <%= errorMessage %>
                </div>

            <%
                }
            %>


            <!-- REGISTRATION FORM -->

            <form action="register" method="post">


                <!-- NAME -->

                <div class="form-group">

                    <label for="name">
                        Full Name
                    </label>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        placeholder="Enter your full name"
                        required
                    >

                </div>


                <!-- EMAIL -->

                <div class="form-group">

                    <label for="email">
                        Email Address
                    </label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Enter your email"
                        required
                    >

                </div>


                <!-- PASSWORD -->

                <div class="form-group">

                    <label for="password">
                        Password
                    </label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Create a password"
                        required
                    >

                </div>


                <!-- CONFIRM PASSWORD -->

                <div class="form-group">

                    <label for="confirmPassword">
                        Confirm Password
                    </label>

                    <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        placeholder="Confirm your password"
                        required
                    >

                </div>


                <!-- REGISTER BUTTON -->

                <button type="submit">
                    Create Account
                </button>

            </form>


            <!-- LOGIN LINK -->

            <div class="login-link">

                Already have an account?

                <a href="login.jsp">
                    Login
                </a>

            </div>

        </div>

    </main>

</body>

</html>