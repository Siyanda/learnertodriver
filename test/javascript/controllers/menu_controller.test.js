import MenuController from "../../../app/javascript/controllers/menu_controller.js";

describe("MenuController", () => {
  let controller;
  let optionMock, iconMock;

  beforeEach(() => {

    optionMock = { classList: { toggle: jest.fn() } };
    iconMock = { classList: { toggle: jest.fn() } };

    controller = new MenuController();

    controller.optionTarget = optionMock;
    controller.iconTarget = iconMock;
  });

  it("toggles classes on option and icon elements", () => {
    controller.toggle();

    expect(optionMock.classList.toggle).toHaveBeenCalledWith("active");
    expect(iconMock.classList.toggle).toHaveBeenCalledWith("active");
  });
});
