/// <reference types="cypress" />

describe('Jungle Web App', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("User adds Scented Blade to the cart", () => {
    cy.get(".button_to button")
      // 1st element
      .eq(0)
      // had to force - not sure why 'sign up' was covering it according to cypress
      .click({ force: true });

    // test to see if it really is added to the cart
    // gets class of .nav-link and has attribute of href="/cart"
    cy.get(".nav-link[href='/cart']").should('contain.text', '(1)'); // Verifying the changed text
  });
});
