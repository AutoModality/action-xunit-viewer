# XUnit Viewer Github Action
XUnit / JUnit HTML Test Reports

Uses [XUnit Viewer](https://github.com/lukejpreston/xunit-viewer) to generate reports in Github Action Workflows.

## Usage

See [Workflow Example](./.github/workflows/release.yml) for tests and workflow examples and 
the corresponding Action Run.

---
[![Release](https://github.com/AutoModality/action-xunit-viewer/workflows/Release/badge.svg)](https://github.com/AutoModality/action-xunit-viewer/actions)

---

**Note**: `if:always()` is needed to ensure test results are published when test runners return a failing exit code.



### Default Use

Assumes your test reports exist in a folder named `test-reports` and generates the 
report at `test-reports/index.html`. 

This test will report a failure if any of the tests failed or errored.  `fail=false` will disable.

```
name: Test
on: push
jobs:
  test:
    runs-on: ubuntu-18.04
    name: Generate Test Reports
    steps:
      - name: XUnit Viewer
        id: xunit-viewer
        uses: AutoModality/action-xunit-viewer@v1  
      - name: Attach the report
        uses: actions/upload-artifact@v1
        with:
          name: ${{ steps.xunit-viewer.outputs.report-name }}
          path: ${{ steps.xunit-viewer.outputs.report-dir }}

```

### Provide Report Path

Provide an alternate path to the directory where the xml results exist.  The report will be generated in the directory where the results are found.

```
name: Test
on: push
jobs:
  test:
    runs-on: ubuntu-18.04
    name: Generate Test Reports
    env:
      RESULTS_PATH: alternate-location
    steps:
      - name: Generate Report
        id: xunit-viewer
        uses: AutoModality/action-xunit-viewer@v1
        with:
          results: ${{ env.RESULTS_PATH }}
      - name: The generated report
        run: echo "The report is ${{ steps.xunit-viewer.outputs.report-file }}"    
      - name: Attach the report
        uses: actions/upload-artifact@v1
        with:
          name: alternate-results-path-reports
          path: ${{ env.RESULTS_PATH }}

```
