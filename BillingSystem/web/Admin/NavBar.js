class Header extends HTMLElement {
  constructor() {
    super();
  }

  connectedCallback() {
    this.innerHTML = `
          <header align="center">
          <div class="container">
            <nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color: #f2f2f2;">
              <div class="container-fluid">
                  <a class="navbar-brand" href="./FileManager.php">Billing System</a>
                  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarSupportedContent">
                  <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                      <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="./HomePage.jsp">Home</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" href="./Profile.jsp">Profile</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" href="./Cashiers.jsp">Cashiers</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" href="./Bills.jsp">Bills</a>
                      </li>
                  </ul>
                  <form action="../Authentication/Login.html" method="get" class="d-flex">
                    <button class="btn btn-outline-secondary" type="submit">Logout</button>
                  </form>
              </div>
            </nav>
          </div>
      </header>`;
  };
}

customElements.define('header-component', Header);