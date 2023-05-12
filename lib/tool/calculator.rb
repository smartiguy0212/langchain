# frozen_string_literal: true

require "eqn"

module Tool
  class Calculator < Base
    DESCRIPTION = "Useful for getting the result of a math expression. " +
      "The input to this tool should be a valid mathematical expression that could be executed by a simple calculator."

    # Evaluates a pure math expression or if equation contains non-math characters (e.g.: "12F in Celsius") then
    # it uses the google search calculator to evaluate the expression
    # @param input [String] math expression
    # @return [String] Answer
    def self.execute(input:)
      Eqn::Calculator.calc(input)
    rescue Eqn::ParseError
      # Sometimes the input is not a pure math expression, e.g: "12F in Celsius"
      # We can use the google answer box to evaluate this expression
      hash_results = Tool::SerpApi.execute_search(input: input)
      hash_results.dig(:answer_box, :to)
    end
  end
end
