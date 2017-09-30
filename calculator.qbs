import qbs 1.0
import qbs.Utilities

Project {
    name: "Calculator"

    readonly property string version: "1.0.0"

    property bool useStaticAnalyzer: false

    property bool withFluid: qbs.targetOS.contains("windows") ||
                             qbs.targetOS.contains("macos") ||
                             qbs.targetOS.contains("android")

    minimumQbsVersion: "1.6"

    qbsSearchPaths: {
        var paths = [];
        if (withFluid)
            paths.push("fluid/qbs/shared");
        return paths;
    }

    references: [
        "src/src.qbs",
    ]

    SubProject {
        filePath: "fluid/fluid.qbs"

        Properties {
            condition: withFluid
            autotestEnabled: false
            deploymentEnabled: false
            withDocumentation: false
            withDemo: false
        }
    }
}
