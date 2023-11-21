/// <reference types="cypress" />

describe('Jungle Web App', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("User clicks on Giant Tea", () => {
    cy.contains(".products article", "Giant Tea")
      .click();

    cy.get("article.product-detail").should("be.visible");

    // don't hardcode the value because that might change
    // test if the quantity paragraph exists / visible
    cy.get("article.product-detail div .quantity").should("be.visible");

    // test if the price paragraph exists / visible
    cy.get("article.product-detail div .price").should("be.visible");

    // test if the description paragraph exists / visible
    cy.get("article.product-detail div p").should("be.visible");

    // test if the main picture (not thumbnail) exists / visible
    cy.get("article.product-detail .main-img").should("be.visible");
  });
});
