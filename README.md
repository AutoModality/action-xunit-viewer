# XUnit Viewer Github Action
XUnit / JUnit HTML Test Reports

Uses [XUnit Viewer](https://github.com/lukejpreston/xunit-viewer) to generate reports in Github Action Workflows.

## Usage

See [test.yml](./.github/workflows/test.yml) for complete examples.


### Default Use

Assumes your test reports exist in a folder named `test-reports` and generates the 
report at `test-reports/index.html`. 

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
      - name: The generated report
        run: echo "The report is ${{ steps.xunit-viewer.outputs.report-file }}"    
      - name: Attach the report
        uses: actions/upload-artifact@v1
        with:
          name: test-reports
          path: test-reports


```