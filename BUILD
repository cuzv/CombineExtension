load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_bundle")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CombineExtension",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    data = [
        ":CombineExtensionResources",
    ],
    module_name = "CombineExtension",
    visibility = [
        "//visibility:public",
    ],
    deps = [
        "//internals/Infra",
        "@CombineCocoa",
        "@CombineExt",
    ],
)

apple_resource_bundle(
    name = "CombineExtensionResources",
    bundle_name = "CombineExtension",
    resources = glob([
        "Resources/*",
    ]),
)
