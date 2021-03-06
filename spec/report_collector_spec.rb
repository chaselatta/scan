describe Scan do
  describe Scan::ReportCollector do
    let (:path) { "./spec/fixtures/boring.log" }

    it "ignores invalid report types" do
      options = {
        output_types: "invalid, html",
        output_directory: "/tmp",
        project: "examples/standard/app.xcodeproj"
      }
      Scan.config = FastlaneCore::Configuration.create(Scan::Options.available_options, options)

      commands = Scan::ReportCollector.new.generate_commands(path)

      expect(commands.count).to eq(1)
      expect(commands).to eq({
        "/tmp/report.html" => "cat './spec/fixtures/boring.log' |  xcpretty --report html --output '/tmp/report.html' &> /dev/null "
      })
    end
  end
end
